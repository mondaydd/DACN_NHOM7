package vn.nhom18.shoppingclothes.service.validator;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

@Constraint(validatedBy = CustomEmailValidator.class)
// @Target({ ElementType.FIELD, ElementType.PARAMETER })
@Target({ ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface EmailChecked {
    String message() default "Email validation failed";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
