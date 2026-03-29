package com.polycoffee.utils;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class MailerService {
    private static final java.util.Properties config = new java.util.Properties();

    static {
        try (java.io.InputStream input = MailerService.class.getClassLoader()
                .getResourceAsStream("config.properties")) {
            if (input == null) {
                System.err.println("Sorry, unable to find config.properties");
            } else {
                config.load(input);
            }
        } catch (java.io.IOException ex) {
            ex.printStackTrace();
        }
    }

    private static String getUsername() {
        return config.getProperty("mail.username");
    }

    private static String getPassword() {
        return config.getProperty("mail.password");
    }

    public static void send(String to, String subject, String body) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(getUsername(), getPassword());
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(getUsername()));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi gửi mail: " + e.getMessage());
        }
    }
}