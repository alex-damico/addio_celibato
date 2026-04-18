package dev.alessandrodamico.addio_celibrato.controllers;

import dev.alessandrodamico.addio_celibrato.dtos.*;
import dev.alessandrodamico.addio_celibrato.services.HintService;
import dev.alessandrodamico.addio_celibrato.services.QuestionService;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/hints")
@Tag(name = "Hints")
public class HintController {
    private final HintService service;

    public HintController(HintService service) {
        this.service = service;
    }

    @GetMapping("/{questionId}/firstPosition")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", content = {@Content(mediaType = "application/json",
                    schema = @Schema(implementation = HintDto.class))}),
            @ApiResponse(responseCode = "400", content = @Content),
            @ApiResponse(responseCode = "404", content = @Content)})
    public ResponseEntity<HintDto> findFirstPosition(@PathVariable Long questionId) {
        return ResponseEntity.ok(this.service.findFirstPosition(questionId));
    }

    @PostMapping("/")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", content = {@Content(mediaType = "application/json",
                    schema = @Schema(implementation = Long.class))}),
            @ApiResponse(responseCode = "400", content = @Content),
            @ApiResponse(responseCode = "403", content = @Content)
    })
    public ResponseEntity<Long> create(@RequestBody CreateHintDto createHintDto) {
        return new ResponseEntity<>(this.service.add(createHintDto), HttpStatus.CREATED);
    }

    @PatchMapping("/{id}/isUnlocked")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", content = @Content),
            @ApiResponse(responseCode = "400", content = @Content),
            @ApiResponse(responseCode = "404", content = @Content),
            @ApiResponse(responseCode = "409", content = @Content)
    })
    public ResponseEntity<HintDto> updateIsUnlocked(
            @PathVariable Long id) {
        return ResponseEntity.ok(this.service.updateIsUnlocked(id));
    }

}
