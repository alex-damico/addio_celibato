package dev.alessandrodamico.addio_celibrato.controllers;

import dev.alessandrodamico.addio_celibrato.dtos.QuestionDto;
import dev.alessandrodamico.addio_celibrato.services.QuestionService;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/questions")
public class QuestionController {
    private final QuestionService service;

    public QuestionController(QuestionService service) {
        this.service = service;
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = QuestionDto.class)) }),
            @ApiResponse(responseCode = "400", content = @Content),
            @ApiResponse(responseCode = "404", content = @Content) })
    @GetMapping("firstPosition")
    public ResponseEntity<QuestionDto> findFirstPosition() {
        return ResponseEntity.ok(this.service.findFirstPosition());
    }

}
