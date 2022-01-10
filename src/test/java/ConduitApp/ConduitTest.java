package ConduitApp;


import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit5.Karate;


//@KarateOptions( tags = {"@debug"})
class ConduitTest {

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }


}
