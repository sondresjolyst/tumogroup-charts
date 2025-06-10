## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  helm repo add tumogroup https://sondresjolyst.github.io/tumogroup-charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
tumogroup` to see the charts.

To install the tumogroup chart:

    helm install my-tumogroup tumogroup/tumogroup

To uninstall the chart:

    helm uninstall my-tumogroup