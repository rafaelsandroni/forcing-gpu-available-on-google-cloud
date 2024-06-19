# Brute force to setup GPU on Google Cloud / GCP 

Script to set up a Google Cloud Platform (GCP) instance with an L4 GPU and `n1-standard-8` machine type. It also installs Jupyter Notebook and makes it accessible remotely.

## What You'll Need

1. A GCP account and project.
2. Google Cloud SDK installed and configured.

## Getting Started

1. **Clone this repo:**

    ```sh
    git clone https://github.com/yourusername/gcp-instance-setup.git
    cd gcp-instance-setup
    ```

2. **Make the script executable:**

    ```sh
    chmod +x setup_gcp_instance.sh
    ```

3. **Update your project ID:**

    Open `setup_gcp_instance.sh` and replace `YOUR_PROJECT_ID` with your actual GCP project ID.

4. **Run the script:**

    ```sh
    ./setup_gcp_instance.sh
    ```

5. **Follow the instructions:**

    The script will tell you how to access the Jupyter Notebook once it's set up.

## What the Script Does

1. **Sets your GCP project:**
    ```sh
    gcloud config set project YOUR_PROJECT_ID
    ```

2. **Gets available zones:**
    ```sh
    gcloud compute zones list --format="value(name)"
    ```

3. **Tries to create an instance in each zone:**
    It loops through zones until it finds one that works.

4. **Installs Jupyter Notebook:**
    SSHs into the instance, installs Jupyter, and starts it.

5. **Provides access instructions:**
    Tells you how to SSH into the instance and access Jupyter Notebook.

## Notes

- Make sure you have enough quota for L4 GPUs and `n1-standard-8` instances.
- The instance is set to terminate during maintenance. You can change this in the script if needed.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Thanks

- [Google Cloud Platform](https://cloud.google.com/)
- [Google Cloud SDK](https://cloud.google.com/sdk)

Happy computing!
