# File Permissions & File Operations Challenge

## Create files
touch devops.txt

```bash
cat > notes.txt <<EOF
Linux file permissions practice
File ownership controls access
chmod changes permissions
EOF

vim script.sh
```

Inside vim:
```bash
i
echo "Hello DevOps"
Esc
:wq
```


```bash
# Inspect permissions
ls -l devops.txt notes.txt script.sh

# Read files
cat notes.txt
vim -R script.sh
head -n 5 /etc/passwd
tail -n 5 /etc/passwd

# Make script executable
chmod +x script.sh
./script.sh

#Create the below file
touch devops.txt

# Make devops.txt read-only
chmod a-w devops.txt

# Set notes.txt to 640
chmod 640 notes.txt

# Create directory with 755
mkdir project
chmod 755 project

# Verify everything
ls -ld devops.txt notes.txt script.sh project
```

## File created 
- devops.txt — Empty file created using touch
- notes.txt — Text file created with sample Linux permission notes
- script.sh — Shell script created using vim containing echo "Hello DevOps"`
- project/ — Directory created for permission practice

## What i learned
- if the file is open in read only mode then we need to use :q! enter button to come out.

- Linux file permissions control who can read, write, and execute a file. The permissions can be divided into three categories: owner, group, and others.

- I learned how to use chmod to modify permissions. For example, chmod +x script.sh adds execute permission, while chmod 640 notes.txt gives the owner read/write access, the group read access, and others no access.
