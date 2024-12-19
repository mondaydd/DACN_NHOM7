package vn.nhom18.shoppingclothes.service.validator;

import org.springframework.stereotype.Service;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import vn.nhom18.shoppingclothes.domain.User;
import vn.nhom18.shoppingclothes.service.UserService;

@Service
public class CustomEmailValidator implements ConstraintValidator<EmailChecked, User> {
    private final UserService userService;
    

    public CustomEmailValidator(UserService userService) {
        this.userService = userService;
    }

    // @Override
    // public void initialize(EmailChecked constraintAnnotation) {
    //     this.userService = (UserService) ContextProvider.getBean(UserService.class);
    // }

    // @Override
    // public boolean isValid(String arg0, ConstraintValidatorContext arg1) {
    //     boolean valid = true;
    //     if (this.userService.checkedEmailExist(arg0)) {
    //         arg1.buildConstraintViolationWithTemplate("Email đã tồn tại")
    //                 .addPropertyNode("email")
    //                 .addConstraintViolation()
    //                 .disableDefaultConstraintViolation();
    //         valid = false;
    //     }
    //     return valid;
    // }
    @Override
    public boolean isValid(User user, ConstraintValidatorContext arg1) {
        boolean valid = true;
        if (this.userService.checkedEmailExist(user.getEmail())) {
            arg1.buildConstraintViolationWithTemplate("Email đã tồn tại")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }
        return valid;
    }
}
