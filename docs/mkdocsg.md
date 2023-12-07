# Comprehensive MkDocs Guide

## Introduction to MkDocs

### What is MkDocs?

MkDocs is a fast, simple and downright gorgeous static site generator that's geared towards building project documentation. Documentation source files are written in Markdown, and configured with a single YAML configuration file.

### Key Features

- **Ease of Use**: MkDocs is straightforward to set up. All you need is your documentation in Markdown format. No database is required.
- **Theme Support**: MkDocs comes with a built-in theme. Additional themes can be installed via `pip`. This site is built with the [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) theme.
- **Host Anywhere**: MkDocs builds completely static HTML sites that you can host on GitHub pages, Amazon S3, or anywhere else you choose.
- **Markdown Centric**: Focus on your project's documentation and not on the tooling to make your documentation work. Additional features can be incorporated via extensions.

## MkDocs Directory Structure

When you create a new project, MkDocs will automatically create the a directory structure and files. If you pull this repository, the directory structure is already set up, which looks like this:

``` title="Directory Structure"
project_name/
│
├── docs/
│   ├── index.md    # The main documentation page.
│   └── ...         # Other markdown pages for your documentation.
│
└── mkdocs.yml      # The MkDocs configuration file.
```

- `docs/`: This directory contains all your documentation in Markdown format.
- `mkdocs.yml`: This is the configuration file for your MkDocs site.

!!! note

    It is possible to have subdirectories within the `docs/` directory. This is useful for organizing the documentation into sections. However, please inform the administrator if you plan to do this.

## MkDocs YAML Configuration

The `mkdocs.yml` file is where you configure your documentation site. YAML, which stands for "YAML Ain't Markup Language," is a human-readable data serialization format. YAML files typically end with the .yml or .yaml extension and use indentation to represent data hierarchies, making it visually clear and straightforward. This format is often preferred for writing configuration files, like those used in MkDocs.

### Basic Configuration:

- **site_name**: Title of your documentation site.
- **nav**: Structure of your site's navigation.

### Example `mkdocs.yml`:

```yaml title="mkdocs.yml"
site_name: QSpace Documentation
nav:
    - Home: index.md
    - About: about.md
    - User Guide:
        - Writing Docs: user-guide/writing.md
        - Styling Docs: user-guide/styling.md
```

!!! warning

    You will see many more configuration options in the `mkdocs.yml` file in this repository. Please do not touch any of the settings other than the ones mentioned above. If you have any questions, please contact the administrator.

## Installing, Building, and Using MkDocs

Before you start building the project, you will need to create a Python virtual environment. A Python environment is a self-contained directory that holds a specific version of Python and a collection of Python packages. Think of it as an isolated workspace for Python projects, ensuring that each project has its own dependencies and settings, separate from other projects. This isolation prevents conflicts between project requirements and allows for more organized and manageable development. The most common tool for creating Python environments is venv, which is included in the Python Standard Library.

### Create a Python Virtual Environment:

```shell
python -m venv venv
```

- `python -m venv`: This command tells Python to create a new virtual environment.
- `venv`: This is the name of the virtual environment folder. You can name it anything, but `venv` is a common convention. The administrator highly recommends using this name for convenience in version control. If you strongly prefers another name, please ensure that this directory is excluded in your `.gitignore` file, and you should not commit your `.gitignore` file to the repository.

!!! note
    
    This project has been tested for Python 3.10.11. The command to use may differ depending on the version and platform you are working with. In general, Python 3.10 and above should work without any issues.

### Activate/Deactivate the Virtual Environment:

The Python virtual environment can be activated using the following commands:

=== "Linux/MacOS"

    ```shell
    source venv/bin/activate
    ```

    - `source`: This command changes the current shell’s environment to the one provided.
    - `venv/bin/activate`: This is the path to the activation script of the virtual environment. Running this script activates the virtual environment.

=== "Windows"

    ```powershell
    .\venv\Scripts\activate
    ```

    - `.\venv\Scripts\activate`: This command activates the virtual environment on Windows. The path differs slightly from Linux/MacOS.

The Python virtual environment can be deactivated using the following command (same for both Linux/MacOS and Windows):

```shell
deactivate
```

!!! warning

    You must activate the virtual environment every time you start working with this project. Otherwise, you will be using the system Python environment, which may cause conflicts with the packages you install. Also, please remember to deactivate the virtual environment when you are done working with this project.

### Install MkDocs and Dependencies:

The required packages and relevant dependencies (together with the required version) are listed in the `requirements.txt` file. To install these packages, run the following command:

```shell
pip install -r requirements.txt
```

- `pip install -r`: This command is used to install packages listed in `requirements.txt` from the Python Package Index (PyPI).
- `requirements.txt`: This file includes all the packages and dependencies for the project. Please do not modify this file before consulting the administrator.

### Start the MkDocs Server:

MkDocs allows you to preview your documentation as you work on it, by running the website locally on your computer. Every time you make changes to your documentation, you can see the changes in real time in your browser. To start the MkDocs server, run the following command:

```shell
mkdocs serve
```

- `mkdocs serve`: This command starts a local server for your MkDocs site. It allows you to see your changes in real time as you work on your documentation.

- After running this command, MkDocs will start a web server accessible at `http://localhost:8000`. You can open this address in your web browser to see your documentation.

### Building Your Site:

```shell
mkdocs build
```

- `mkdocs build`: This command generates the static HTML files for your documentation. After running this command, you'll find these files in a folder named `site` within your project directory.

- The generated `site` directory can be hosted on any web server, GitHub Pages, or other hosting services for static sites.

---

By following these steps, you should be able to set up and use MkDocs in your local computers. If you have any questions, please contact the administrator Changkai Zhang at [changkai.zhang@physik.lmu.de](mailto:changkai.zhang@physik.lmu.de).

&nbsp;
