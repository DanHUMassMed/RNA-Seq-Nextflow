read1=$1
read2=$2
mount_dir=$PWD
container_dir=/usr/data

#http://proteo.me.uk/2013/09/a-new-way-to-look-at-duplication-in-fastqc-v0-11/

remove_last_chars() {
    local original_string="$1"
    local chars_to_remove="$2"
    local length="${#original_string}"
    local modified_string="${original_string:0:$((length - chars_to_remove))}"
    echo "$modified_string"
}


out_dir="fastqc_$(basename "$read1")"
out_dir=$(remove_last_chars "$out_dir" 8)
out_dir=${out_dir}_log
mkdir -p ${mount_dir}/${out_dir}

docker run --platform linux/amd64 --rm -v ${mount_dir}:${container_dir} -t danhumassmed/qc-tools:1.0.1 fastqc \
	-o ${container_dir}/${out_dir} -f fastq -q ${container_dir}/${read1} ${container_dir}/${read2}



