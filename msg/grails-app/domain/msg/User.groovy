package msg

class User extends AuthUser{

    static constraints = {
        name blank: false, nullable: false
        screenName blank: false, nullable: false, unique: true
        email blank: false, nullable: false, email: true
    }

    String name
    String screenName
    String email

}
