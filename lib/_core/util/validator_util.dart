import 'package:validators/validators.dart';

String validateUsername(String value) {
  final v = value.trim();

  // 1) 비어있음
  if (v.isEmpty) {
    return "아이디는 비워둘 수 없습니다.";
  }

  // 2) 길이 5~20
  if (v.length < 5) {
    return "아이디는 최소 5자 이상이어야 합니다.";
  }
  if (v.length > 20) {
    return "아이디는 최대 20자 이하여야 합니다.";
  }

  // 3) 허용 문자: 소문자 a-z, 숫자 0-9, '-', '_'
  final allowed = RegExp(r'^[a-z0-9\-_]+$');
  if (!allowed.hasMatch(v)) {
    return "아이디는 소문자, 숫자, 하이픈(-), 밑줄(_)만 사용할 수 있습니다.";
  }

  // 4) 시작/끝은 영문/숫자여야 함
  final startEndOk = RegExp(r'^[a-z0-9].*[a-z0-9]$');
  if (!startEndOk.hasMatch(v)) {
    return "아이디는 영문/숫자로 시작하고 끝나야 합니다.";
  }

  // 5) 특수문자 연속 금지: __, --, _-, -_
  final consecutiveSpecial = RegExp(r'(--|__|_-|-_)');
  if (consecutiveSpecial.hasMatch(v)) {
    return "하이픈/밑줄을 연속으로 사용할 수 없습니다.";
  }

  // 모두 통과
  return "";
}

String validatePassword(String value) {
  if (value.isEmpty) {
    return "패스워드 공백이 들어갈 수 없습니다.";
  } else if (value.length > 12) {
    return "패스워드의 길이를 초과하였습니다.";
  } else if (value.length < 4) {
    return "패스워드의 최소 길이는 4자입니다.";
  } else {
    return "";
  }
}

String validatePasswordConfirm(String password, String passwordConfirm) {
  if (passwordConfirm.isEmpty) {
    return "비밀번호 확인을 입력해주세요";
  }
  if (password != passwordConfirm) {
    return "비밀번호가 일치하지 않습니다";
  }
  return "";
}

String validateEmail(String value) {
  if (value.isEmpty) {
    return "이메일은 공백이 들어갈 수 없습니다.";
  } else if (!isEmail(value)) {
    return "이메일 형식에 맞지 않습니다.";
  } else {
    return "";
  }
}

String validateContent(String value) {
  if (value.isEmpty) {
    return "내용은 공백이 들어갈 수 없습니다.";
  } else if (value.length > 500) {
    return "내용의 길이를 초과하였습니다.";
  } else {
    return "";
  }
}
