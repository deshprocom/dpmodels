module Constants
  module Error
    module Http
      SUCCESS_CALL = 0
      HTTP_FAILED = 800

      HTTP_NO_CREDENTIAL = 801
      HTTP_INVALID_CREDENTIAL = 802
      HTTP_CREDENTIAL_NOT_MATCH = 803
      HTTP_TOKEN_EXPIRED = 804
      HTTP_LOGIN_REQUIRED = 805
      HTTP_ACCESS_FORBIDDEN = 806

      HTTP_MAX = 899
    end

    module Common
      MISSING_PARAMETER = 1100001
      UNSUPPORTED_TYPE = 1100002
      DATABASE_ERROR = 1100003
      PARAM_FORMAT_ERROR = 1100004
      DATE_FORMAT_ERROR = 1100005
      NOT_FOUND = 1100006
      SYSTEM_ERROR = 1100007
    end

    module Sign
      EMAIL_FORMAT_WRONG = 1100011
      MOBILE_FORMAT_WRONG = 1100012
      MOBILE_ALREADY_USED = 1100013
      EMAIL_ALREADY_USED = 1100014
      PASSWORD_FORMAT_WRONG = 1100015
      USER_NOT_FOUND = 1100016
      PASSWORD_NOT_MATCH = 1100017
      VCODE_NOT_MATCH = 1100018
      VCODE_TYPE_WRONG = 1100019
      NICK_NAME_EXIST = 1100020
      UNSUPPORTED_RESET_TYPE = 1100021
      UNSUPPORTED_OPTION_TYPE = 1100022
      USER_ALREADY_EXIST = 1100023
    end

    module Race
      TICKET_SOLD_OUT = 1100031
      TICKET_UNSOLD = 1100032
      AGAIN_BUY = 1100039
      E_TICKET_SOLD_OUT = 1100040
      TICKET_END = 1100038
    end

    module Address
      NO_ADDRESS = 1100041
    end

    module Order
      CANNOT_CANCEL = 1110000
    end

    module Account
      NO_CERTIFICATION = 1100051
      ALREADY_CERTIFICATION = 1100052
      CERT_NO_FORMAT_WRONG = 1100053
      REAL_NAME_FORMAT_WRONG = 1100054
      CERT_NO_ALREADY_EXIST = 1100055
    end

    module File
      FORMAT_WRONG = 1200001
      SIZE_TOO_LARGE = 1200002
      CREATE_DIR_FAILED = 1200003
      UPLOAD_FAILED = 1200004
    end
  end

  ERROR_MESSAGES = {
    Error::Http::SUCCESS_CALL => 'OK',

    Error::Http::HTTP_NO_CREDENTIAL => '请求缺少身份信息',
    Error::Http::HTTP_INVALID_CREDENTIAL => '无效的请求身份',
    Error::Http::HTTP_CREDENTIAL_NOT_MATCH => '请求身份不匹配',
    Error::Http::HTTP_TOKEN_EXPIRED => 'access token已失效',
    Error::Http::HTTP_LOGIN_REQUIRED => '需要登录后才可以操作',
    Error::Http::HTTP_ACCESS_FORBIDDEN => '无权访问',

    Error::Common::MISSING_PARAMETER => '缺少参数',
    Error::Common::PARAM_FORMAT_ERROR => '参数格式错误',
    Error::Common::DATE_FORMAT_ERROR => '日期格式错误',
    Error::Common::UNSUPPORTED_TYPE => '不支持的类型',
    Error::Common::DATABASE_ERROR => '数据库错误',
    Error::Common::NOT_FOUND => '找不到指定记录',
    Error::Common::SYSTEM_ERROR => '系统错误',
    Error::Sign::EMAIL_FORMAT_WRONG => '无效的邮箱格式',
    Error::Sign::MOBILE_FORMAT_WRONG => '无效的手机号码',
    Error::Sign::MOBILE_ALREADY_USED => '手机号码已被使用',
    Error::Sign::EMAIL_ALREADY_USED => '邮箱已被使用',
    Error::Sign::PASSWORD_FORMAT_WRONG => '密码格式不正确',
    Error::Sign::USER_NOT_FOUND => '用户不存在',
    Error::Sign::USER_ALREADY_EXIST => '用户已存在',
    Error::Sign::PASSWORD_NOT_MATCH => '用户密码不匹配',
    Error::Sign::VCODE_NOT_MATCH => '验证码不匹配',
    Error::Sign::VCODE_TYPE_WRONG => '验证码类型不匹配',
    Error::Sign::UNSUPPORTED_RESET_TYPE => '不支持的重置类型 ',
    Error::Sign::UNSUPPORTED_OPTION_TYPE => '不支持的操作类型 ',

    Error::File::FORMAT_WRONG => '文件格式有误',
    Error::File::SIZE_TOO_LARGE => '文件大小超过限制',
    Error::File::CREATE_DIR_FAILED => '创建目录失败',
    Error::File::UPLOAD_FAILED => '文件上传失败',

    Error::Race::TICKET_SOLD_OUT => '票已卖完',
    Error::Race::TICKET_END => '售票已结束',
    Error::Race::TICKET_UNSOLD => '售票还没开始',
    Error::Race::AGAIN_BUY => '您已购买过该票，不允许再次购买',
    Error::Race::E_TICKET_SOLD_OUT => '电子票已售完',

    Error::Order::CANNOT_CANCEL => '当前状态不允许取消订单',

    Error::Account::NO_CERTIFICATION => '用户未实名',
    Error::Account::REAL_NAME_FORMAT_WRONG => '真实姓名格式错误',
    Error::Account::CERT_NO_FORMAT_WRONG => '身份证格式错误',
    Error::Account::CERT_NO_ALREADY_EXIST => '该用户已实名'
  }.freeze
end
