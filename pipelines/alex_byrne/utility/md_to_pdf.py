import subprocess
import json

def execute_rclone(remote_location):
    # Construct the command
    command = f'rclone lsl remote:"{remote_location}" --human-readable'

    # Execute the command and capture the output
    try:
        output = subprocess.check_output(command, shell=True, text=True)
        # Split the output into lines and parse it into a list of dictionaries
        lines = output.strip().split('\n')
        data = []
        for line in lines:
            # Split each line into columns (assuming space is the delimiter)
            columns = line.split()
            # Concatenate columns from index 3 to the last value to form the 'directory' key
            directory = ' '.join(columns[3:])
            # Create a dictionary for each line
            entry = {
                'size': columns[0],
                'date': columns[1],
                'timestamp': columns[2],
                'directory': directory
            }
            data.append(entry)
        # Convert the list of dictionaries to JSON
        json_data = json.dumps(data, indent=4)
        return json_data
    except subprocess.CalledProcessError as e:
        return json.dumps({'error': str(e)}, indent=4)

# Example usage
REMOTE_LOCATION = "RNA-seq/daf19 & tir1 RNAseq Working Files"
#REMOTE_LOCATION = "SamLiu_ Francis lab September 2023"
result = execute_rclone(REMOTE_LOCATION)
print(result)
