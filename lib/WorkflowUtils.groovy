import nextflow.Nextflow
import java.util.UUID

class WorkflowUtils {

    public static void initialize(params, log) {
        if(!params.data_remote) {
          Nextflow.error("ERROR: params.data_remote is required for this pipeline. Please add to config and resume")
        }
    }

    public static List<String> generateUUIDs(int numberOfUUIDs) {
        List<String> uuidList = []
        for (int i = 0; i < numberOfUUIDs; i++) {
            UUID uuid = UUID.randomUUID()
            uuidList.add(uuid.toString())
        }
        return uuidList
    }

}