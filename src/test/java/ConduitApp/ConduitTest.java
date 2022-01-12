package ConduitApp;


import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;


//@KarateOptions( tags = {"@debug"})
class ConduitTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:ConduitApp")
                //.outputCucumberJson(true)
                .parallel(4);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }


}
