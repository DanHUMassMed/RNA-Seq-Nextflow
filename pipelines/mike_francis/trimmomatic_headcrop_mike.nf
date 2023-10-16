#!/usr/bin/env nextflow 

// nextflow run pipelines/mike_francis/trimmomatic_headcrop_mike.nf -bg -N daniel.higgins@umassmed.edu

import java.util.UUID

List<String> generateUUIDs(int numberOfUUIDs) {
    List<String> uuidList = []
    for (int i = 0; i < numberOfUUIDs; i++) {
        UUID uuid = UUID.randomUUID()
        uuidList.add(uuid.toString())
    }
    return uuidList
}


nextflow.enable.dsl = 2

params.reads = "${projectDir}/data/Experiment3/**/*_{1,2}.fq.gz"
params.data_root="Experiment3"
params.outdir = "${projectDir}/results"

log.info """\
 TRIMMOMATIC - N F   P I P E L I N E
 ===================================
 reads        : ${params.reads}
 outdir       : ${params.outdir}
 base_dir     : ${baseDir}
 """

// import modules
include { TRIM_HEADCROP; TRIM_AGGREGATE } from "${launchDir}/modules/trimmomatic"

/* 
 * main script flow
 */
workflow {
  read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true )
  dir_suffix = channel.fromList(generateUUIDs(50))

  TRIM_HEADCROP( read_pairs_ch, params.data_root, dir_suffix )
  TRIM_AGGREGATE(TRIM_HEADCROP.out.collect() )
}

/* 
 * completion handler
 */
workflow.onComplete {
  def msg = """\
        Pipeline execution summary
        ---------------------------
        Completed at: ${workflow.complete}
        Duration    : ${workflow.duration}
        Success     : ${workflow.success}
        workDir     : ${workflow.workDir}
        exit status : ${workflow.exitStatus}
        """
        .stripIndent()

    sendMail(to: 'daniel.higgins@umassmed.edu', subject: 'TRIMMOMATIC completed', body: msg)

	log.info ( workflow.success ? "\nDone! The results can be found in --> ${baseDir}/${params.outdir}/trimmed\n" : "Oops .. something went wrong" )
}
