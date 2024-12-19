package vn.nhom18.shoppingclothes.service.validator;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class ContextProvider implements ApplicationContextAware {
    private static ApplicationContext applicationContext;

    public static Object getBean(Class cls) {
        return ContextProvider.applicationContext.getBean(cls);
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        // TODO Auto-generated method stub
        ContextProvider.applicationContext = applicationContext;
    }
}
