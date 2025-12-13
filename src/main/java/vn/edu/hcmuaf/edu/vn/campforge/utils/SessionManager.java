package vn.edu.hcmuaf.edu.vn.campforge.utils;

import jakarta.servlet.http.HttpSession;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class SessionManager {
    public static Map<String, HttpSession> userSessions = new ConcurrentHashMap<>();
}