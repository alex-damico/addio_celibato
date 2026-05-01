package dev.alessandrodamico.addio_celibrato;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(properties = {
    "spring.liquibase.enabled=false",
    "spring.datasource.url=jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1;MODE=PostgreSQL"
})
class AddioCelibratoApplicationTests {

	@Test
	void contextLoads() {
	}

}
