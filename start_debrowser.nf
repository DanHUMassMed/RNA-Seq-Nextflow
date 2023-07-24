#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2


log.info """\
 START DEBROWSERS 

 ssh -L 8081:<HPC_HOST>:8081 daniel.higgins-umw@hpc.umassmed.edu

 """

// import modules
include { DEBROWSER } from './modules/debrowser'

workflow {
 DEBROWSER( )
}

