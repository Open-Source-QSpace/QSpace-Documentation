import os

# Set the source and target directories
source_dir = '../osqs/bin/'
target_dir = '../docs/reference/'

# Create the target directory if it does not exist
os.makedirs(target_dir, exist_ok=True)

# Iterate over each file in the source directory
for filename in os.listdir(source_dir):
    # Check if the file has a '.m' extension
    if filename.endswith('.m'):
        # Read the content of the source file
        with open(os.path.join(source_dir, filename), 'r') as file:
            content = file.read()

        # Process the content: replace '% ' with '' and '%\n' with '\n'
        processed_content = content.replace('%  ', '').replace('%\n', '\n')

        # Prepare the Markdown content
        markdown_content = '```\n' + ''.join(processed_content) + '```' + \
            '\n&nbsp;'

        # Write the Markdown content to the target file with the same name but '.md' extension
        with open(os.path.join(target_dir, filename.replace('.m', '.md')), 'w') as file:
            file.write(markdown_content)

print("Conversion completed.")
