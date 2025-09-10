// lib/ui/pages/auth/join/join_email_handlers.dart
//
// 목적:
// - 이메일 단계의 흐름(로컬검증 → 서버체크 진행중 안내 → 가용성 결과 확인 → 다음 화면 이동)을
//   폼 모델(JoinFM) 밖으로 분리하여 가독성과 테스트 용이성을 높인다.
// - 화면 전환/스낵바 같은 UI 부작용을 이 파일에서 처리해, VM은 "상태 관리"에 집중하게 한다.
//
// 설계 포인트:
// - 모든 핸들러는 JoinModel(읽기)만 받아 로직을 판단한다.
// - 상태 쓰기는 콜백(syncEmailError)으로만 수행하여 VM 의존을 최소화한다.
// - 메시지/네비게이션은 navigatorKey 기반 유틸 함수로 한 곳에서 실행한다(컨텍스트 의존 제거).
//
// 사용 흐름:
//  confirmEmailFlow(state: vm.state, syncEmailError: (e) => vm.state = vm.state.copyWith(emailError: e));
//  → 내부에서 가드 함수들이 순차적으로 검사/안내/이동을 수행하고, 성공 시 true 반환.

import 'package:flutter/material.dart';
import 'package:minigram/_core/util/validator_util.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/main.dart';
import 'package:minigram/ui/pages/auth/join_page/join_fm.dart'; // 글로벌 navigatorKey 사용

// 내부 유틸: 스낵바 표출
// - 화면 어디서든 메시지를 띄우기 위해 navigatorKey.currentContext를 사용.
// - 현재 스크린이 없을 수 있어 null-safe 체크.
void _showSnack(
  String message, {
  Duration duration = const Duration(seconds: 2),
  SnackBarBehavior behavior = SnackBarBehavior.fixed, // 또는 floating
}) {
  final ctx = navigatorKey.currentContext;
  if (ctx == null) return;
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: duration,
      behavior: behavior,
    ),
  );
}

// 내부 유틸: 다음 스텝(유저네임)으로 네비게이션
// - 이메일 단계가 성공적으로 통과했을 때 호출.
// - 실제 라우트 이름은 프로젝트 상수에 맞춰 사용.
void _goToUsernameStep() {
  final ctx = navigatorKey.currentContext;
  if (ctx == null) return;
  Navigator.pushNamed(ctx, MRoute.joinUsername);
}

// 1) 로컬 형식 검증 처리
// - 입력된 이메일이 유효한 형식인지 즉시 검사.
// - 오류가 있으면 스낵바로 안내 + 폼 상태의 emailError를 동기화.
// 반환: 처리했으면 true(=더 진행 중단), 통과하면 false
bool handleLocalEmailValidation(
  JoinModel state,
  void Function(String err) syncEmailError,
) {
  final emailErr = validateEmail(state.email);
  if (emailErr.isEmpty) return false; // 통과 → 다음 가드로

  // 오류 메시지 표출 및 상태 동기화
  _showSnack(emailErr);
  syncEmailError(emailErr);
  return true; // 여기서 종료
}

// 2) 서버 중복검사 진행 중 안내
// - 디바운스 후 서버 중복확인이 돌고 있는 동안 사용자가 '다음'을 누르면
//   대기 메시지를 보여주고 진행을 막는다(경쟁 상태/미확정 방지).
// 반환: 진행 중이면 true(=중단), 아니면 false
bool handleEmailCheckingInProgress(JoinModel state) {
  if (!state.isEmailChecking) return false;
  _showSnack("이메일 중복 확인 중입니다. 잠시만 기다려주세요.");
  return true;
}

// 3) 서버 가용성 결과 처리
// - 서버가 "가용(true)"가 아니면 실패 처리.
// - false(중복)인 경우 에러 문구를 폼 상태에 동기화해 하단 에러텍스트/아이콘 표시와 일관성 유지.
// - null(미확정)인 경우에는 "중복 확인이 필요" 메시지 안내.
// 반환: 실패 처리하면 true(=중단), 통과하면 false
bool handleEmailAvailabilityFailure(
  JoinModel state,
  void Function(String err) syncEmailError,
) {
  if (state.isEmailAvailable == true) return false; // 사용 가능 → 통과

  final msg = state.isEmailAvailable == false ? "이미 사용 중인 이메일입니다." : "이메일 중복 확인이 필요합니다.";
  _showSnack(msg);

  // 중복 확정(false)일 때는 상태에도 에러 반영(UX 일관성)
  if (state.isEmailAvailable == false) {
    syncEmailError("이미 사용 중인 이메일입니다.");
  }
  return true;
}

// 4) 네비게이션
// - 모든 가드 통과 후 다음 스텝 이동.
// - 분리해두면 나중에 애니메이션/파라미터 전달 등 확장시 수정 범위를 최소화 가능.
void goToNextStep() => _goToUsernameStep();

// 공개 API: 이메일 확인 플로우
// - 위 1~3 가드를 순서대로 실행하고, 모두 통과하면 4로 이동.
// - VM에서는 이 함수만 호출하면 됨.
// 반환: 성공적으로 다음 화면으로 이동했으면 true, 중간에 막혔으면 false
bool confirmEmailFlow({
  required JoinModel state,
  required void Function(String err) syncEmailError,
}) {
  if (handleLocalEmailValidation(state, syncEmailError)) return false;
  if (handleEmailCheckingInProgress(state)) return false;
  if (handleEmailAvailabilityFailure(state, syncEmailError)) return false;
  goToNextStep();
  return true;
}
