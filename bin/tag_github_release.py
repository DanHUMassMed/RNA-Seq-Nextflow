#!/usr/bin/env python3

import http.client
import json
import os

# GitHub repository information
USERNAME = os.environ.get('GITHUB_USERNAME')
ACCESS_TOKEN = os.environ.get('GITHUB_ACCESS_TOKEN')

REPO = "RNA-Seq-Nextflow"
TAG_NAME = "v1.0.0"  # Specify the tag name you want to create
TARGET_COMMITISH = "master"  # Specify the branch or commit hash you want to tag

def get_last_tag(repo_owner, repo_name):
    connection = http.client.HTTPSConnection("api.github.com")
    headers = {"User-Agent": "Python HTTP Client"}
    url = f"/repos/{repo_owner}/{repo_name}/tags"
    
    connection.request("GET", url, headers=headers)
    response = connection.getresponse()
    data = response.read()

    if response.status == 200:
        tags = json.loads(data)
        if tags:
            last_tag_name = tags[0]['name']
            return last_tag_name
        else:
            return "No tags found for the repository."
    else:
        return f"Failed to fetch tags. Status code: {response.status}"


def get_last_commit_hash(repo_owner, repo_name):
    connection = http.client.HTTPSConnection("api.github.com")
    headers = {"User-Agent": "Python HTTP Client"}
    url = f"/repos/{repo_owner}/{repo_name}/commits"
    
    connection.request("GET", url, headers=headers)
    response = connection.getresponse()
    data = response.read()

    if response.status == 200:
        commits = json.loads(data)
        if commits:
            last_commit_hash = commits[0]['sha']
            return last_commit_hash
        else:
            return "No commits found for the repository."
    else:
        return f"Failed to fetch commits. Status code: {response.status}"

    
def create_tag_object(repo_owner, repo_name, last_tag,last_commit_hash):
    # Check if the last commit hash is valid
    if len(last_commit_hash) == 40 and all(c in '0123456789abcdef' for c in last_commit_hash):
        # Increment the number after the last dot in the tag
        last_dot_index = last_tag.rfind('.')
        numeric_part = last_tag[last_dot_index + 1:]
        incremented_numeric_part = str(int(numeric_part) + 1)
        
        # Create the new tag string by replacing the numeric part
        new_tag = last_tag[:last_dot_index + 1] + incremented_numeric_part
        
        # Create a tag object using the new tag and last commit hash
        # tag_object = {
        #     "tag": new_tag,
        #     "message": f"Release {new_tag}",
        #     "object": last_commit_hash,
        #     "type": "commit"
        # }

        tag_object = {
            "tag_name": new_tag,
            "target_commitish": "main",
            "name": f"Release {new_tag}",
            "body": "Release notes and description",
            "draft": False,
            "prerelease": False
        }


        return tag_object
    else:
        return "Invalid commit hash format"


def create_tag(repo_owner, repo_name, new_tag_object, access_token):
    connection = http.client.HTTPSConnection("api.github.com")
    headers = {
        "Authorization": f"token {access_token}",
        "Content-Type": "application/json",
        "User-Agent": "Python HTTP Client"
    }
    url = f"/repos/{repo_owner}/{repo_name}/git/tags"

    payload = json.dumps(new_tag_object)
    
    connection.request("POST", url, body=payload, headers=headers)
    response = connection.getresponse()
    data = response.read()

    json_data = json.loads(data)
    print(f"{json.dumps(json_data, indent=4)}")
    if response.status == 201:
        return "Tag created successfully."
    else:
        return f"Failed to create tag. Status code: {response.status}, Response: {data}"


def create_release(username, repo, tag_object, access_token):
    connection = http.client.HTTPSConnection("api.github.com")
    headers = {
        "Authorization": f"token {access_token}",
        "Content-Type": "application/json",
        "User-Agent": "Python HTTP Client"
    }
    url = f"/repos/{username}/{repo}/releases"

    payload = json.dumps(tag_object)
    
    connection.request("POST", url, body=payload, headers=headers)
    response = connection.getresponse()
    data = response.read()

    if response.status == 201:
        return "Release created successfully."
    else:
        return f"Failed to create release. Status code: {response.status}, Response: {data}"

if __name__ == "__main__":     

    ACCESS_TOKEN = "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"
    print(f"Assess token {ACCESS_TOKEN}")

    last_tag = get_last_tag(USERNAME, REPO)
    print(f"The last tag of the repository is: {last_tag}")
    
    last_commit_hash = get_last_commit_hash(USERNAME, REPO)
    print(f"The last last_commit_hash of the repository is: {last_commit_hash}")

    tag_object = create_tag_object(USERNAME, REPO, last_tag,last_commit_hash)
    print(f"The new tag object of the repository is: {tag_object}")
     
    #res_status = create_tag(USERNAME, REPO, tag_object, ACCESS_TOKEN)
    res_status = create_release(USERNAME, REPO, tag_object, ACCESS_TOKEN)
    print(f"The create_tag res_status is: {res_status}")
     
