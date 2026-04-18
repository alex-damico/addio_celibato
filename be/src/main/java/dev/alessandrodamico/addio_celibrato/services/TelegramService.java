package dev.alessandrodamico.addio_celibrato.services;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Service
public class TelegramService {

    @Value("${telegram.bot.token}")
    private String botToken;

    @Value("${telegram.chat.id}")
    private String chatId;

    private final RestTemplate restTemplate = new RestTemplate();

    public void send(String testo) {
        String url = "https://api.telegram.org/bot" + botToken + "/sendMessage";

        Map<String, String> params = new HashMap<>();
        params.put("chat_id", chatId);
        params.put("text", testo);
        params.put("parse_mode", "Markdown");

        try {
            restTemplate.postForEntity(url, params, String.class);
        } catch (Exception e) {
            System.err.println("error telegram: " + e.getMessage());
        }
    }
}
