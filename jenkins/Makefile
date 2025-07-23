# Run Jenkins deploy script
deploy:
	./deploy.sh

# Clean all helm and k8s resources concerning Jenkins
cleanup:
	./cleanup.sh

# Like cleanup but skip pvc
cleanup-skip-pvc:
	./cleanup.sh --preserve-pvc