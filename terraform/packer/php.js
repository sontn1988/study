{
    "builders": [
        {
            "type": "amazon-ebs",
            "region": "us-west-1",
            "source_ami_filter": {
                "filters": {
                    "architecture": "x86_64",
                    "name": "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64*",
                    "virtualization-type": "hvm"
                },
                "owners": [
                    "099720109477"
                ],
                "most_recent": true
            },
            "instance_type": "t3.medium",
            "ssh_username": "ubuntu",
            "ssh_timeout": "5m",
            "subnet_id": "subnet-88fc5fec",
            "security_group_ids": "sg-eda50b8a",
            "ami_name": "php-ami-stag-{{isotime | clean_resource_name}}",
            "ami_description": "php-ami-stag",
            "tags": {
                "Name": "php-ami-stag-{{isotime | clean_resource_name}}",
                "Environment": "STAG",
                "Type": "php"
            },
            "launch_block_device_mappings": [
                {
                    "delete_on_termination": true,
                    "device_name": "/dev/sda1",
                    "volume_size": "30",
                    "volume_type": "gp2"
                }
            ]
        }
    ],
    "provisioners": [
        {
            "type": "shell",
            "execute_command": "{{.Vars}} sudo -S -E bash '{{.Path}}'",
            "inline": [
                "set -eux",
                "add-apt-repository main",
                "add-apt-repository universe",
                "add-apt-repository restricted",
                "add-apt-repository multiverse",
                "apt-get -y install python-minimal python-apt",
                "apt-add-repository ppa:ansible/ansible",
                "apt-get -y update",
                "apt-get -y install ansible"
            ],
            "pause_before": "30s"
        },
        {
            "type": "ansible-local",
            "playbook_file": "../ansible-sontn/php/playbook/playbook.yml",
            "playbook_dir": "../ansible-sontn/php",
            "inventory_groups": "php",
            "command": "PYTHONUNBUFFERED=1 ansible-playbook -D"
        }
    ]
}