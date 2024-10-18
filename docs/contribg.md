# How to Contribute

## Introduction

When contributing to our this documentation, it's crucial to adhere to a structured Git branching strategy. This ensures that the codebase remains stable and manageable, allowing for efficient development and release processes.

## Branching Strategy

We use three types of branches in our workflow:

1. **Main Branch**: Reserved for production releases.
2. **Develop Branch**: Used for integrating new contents and fixes.
3. **Contributor-Specific Branch (e.g., `<name>`)**: For individual contributors to create new contents or fixes.

### Why This Strategy?

- **Stability**: By restricting direct pushes to the `main` branch, we ensure that only thoroughly reviewed contents get deployed.
- **Continuous Integration**: The `develop` branch serves as an integration point, allowing for regular testing and early detection of conflicts.
- **Ownership and Isolation**: Contributor-specific branches allow contributors to work independently on their tasks without interfering with others' work.

## Workflow Steps and Git Commands

### 1. Setup Your Workspace
Before you start, ensure you have the latest version of the `develop` branch.

```bash
git checkout develop
git pull origin develop
```

### 2. Create Your Contributor-Specific Branch
Create a new branch for your work. Replace `<name>` with your branch name.

```bash
git checkout -b <name>
```

### 3. Implement Your Changes
Make your changes, commit them to your branch. Replace `<commit-message>` with a meaningful description of your changes.

```bash
# Add files to the staging area
git add .

# Commit changes
git commit -m "<commit-message>"
```

### 4. Keep Your Branch Updated
Regularly update your branch with changes from the `develop` branch to avoid conflicts later.

```bash
git checkout develop
git pull origin develop
git checkout <name>
git merge develop
```

Resolve any conflicts that arise from the merge.

### 5. Finalizing Your Contribution
Once your contents or fixes are complete:

- Pull the latest `develop` branch.
- Merge it into your branch.
- Solve any conflicts.

```bash
git checkout develop
git pull origin develop
git checkout <name>
git merge develop
```

### 6. Merge Back to Develop
After resolving conflicts and ensuring the local website works as expected, merge your branch back to `develop`.

```bash
git checkout develop
git merge <name>
```

### 7. Push to Develop
Push your changes to the remote `develop` branch. Your code will be reviewed before merging.

```bash
git push origin develop
```

### 8. Code Review and Testing
Once pushed, your code will undergo review and testing by peers and CI tools.

!!! note

    The `main` branch is off-limits for direct contributions. It is exclusively managed by the administrator for stable releases.

---

This workflow, while structured, ensures that our codebase remains clean, stable, and manageable. By following these guidelines, you contribute not only code but also to the overall health and quality of the project.
