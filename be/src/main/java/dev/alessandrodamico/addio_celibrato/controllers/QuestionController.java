package dev.alessandrodamico.addio_celibrato.controllers;

import dev.alessandrodamico.addio_celibrato.dtos.CreateQuestionDto;
import dev.alessandrodamico.addio_celibrato.dtos.QuestionDto;
import dev.alessandrodamico.addio_celibrato.services.QuestionService;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/questions")
@Tag(name = "Questions")
public class QuestionController {
    private final QuestionService service;

    public QuestionController(QuestionService service) {
        this.service = service;
    }

    @GetMapping("firstPosition")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", content = {@Content(mediaType = "application/json",
                    schema = @Schema(implementation = QuestionDto.class))}),
            @ApiResponse(responseCode = "400", content = @Content),
            @ApiResponse(responseCode = "404", content = @Content)})
    public ResponseEntity<QuestionDto> findFirstPosition() {
        return ResponseEntity.ok(this.service.findFirstPosition());
    }

    @PostMapping("/")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", content = {@Content(mediaType = "application/json",
                    schema = @Schema(implementation = Long.class))}),
            @ApiResponse(responseCode = "400", content = @Content),
            @ApiResponse(responseCode = "403", content = @Content)
    })
    public ResponseEntity<Long> create(@RequestBody CreateQuestionDto createQuestionDto) {
        return new ResponseEntity<>(this.service.add(createQuestionDto), HttpStatus.CREATED);
    }

    @PatchMapping("/{id}/isResolved")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", content = @Content),
            @ApiResponse(responseCode = "400", content = @Content),
            @ApiResponse(responseCode = "404", content = @Content),
            @ApiResponse(responseCode = "409", content = @Content)
    })
    public ResponseEntity<QuestionDto> updateIsRevolved(
            @PathVariable Long id) {
        return ResponseEntity.ok(this.service.updateIsRevolved(id));
    }

    @PatchMapping("/{id}/resetIsResolved")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", content = @Content),
            @ApiResponse(responseCode = "400", content = @Content),
            @ApiResponse(responseCode = "404", content = @Content),
            @ApiResponse(responseCode = "409", content = @Content)
    })
    public ResponseEntity<QuestionDto> updateResetIsRevolved(
            @PathVariable Long id) {
        return ResponseEntity.ok(this.service.updateResetIsRevolved(id));
    }

    @GetMapping("/")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    content = @Content(
                            mediaType = "application/json",
                            schema = @Schema(implementation = Page.class)
                    )
            ),
            @ApiResponse(responseCode = "400", description = "Richiesta non valida", content = @Content),
            @ApiResponse(responseCode = "404", description = "Risorsa non trovata", content = @Content)
    })
    public ResponseEntity<Page<QuestionDto>> getAll(@ParameterObject Pageable pageable) {
        return ResponseEntity.ok(this.service.findAll(pageable));
    }

}
