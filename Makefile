# Pokazuje wszystkie przestrzenie nazw w klastrze
namespaces:
	kubectl get namespaces

# Pokazuje wszystkie pody ze wszystkich przestrzeni nazw
all-pods:
	kubectl get pods --all-namespaces

# Pokazuje wszystkie serwisy ze wszystkich przestrzeni nazw
all-services:
	kubectl get services --all-namespaces

# Pokazuje wszystkie deploymenty ze wszystkich przestrzeni nazw
all-deployments:
	kubectl get deployments --all-namespaces

# Pokazuje bieżący namespace ustawiony w kontekście kubeconfig
active-namespace:
	kubectl config view --minify | grep namespace || echo "Brak jawnie ustawionego namespace – używany 'default'"

# Pokazuje pody tylko z przestrzeni nazw 'default'
pods-default:
	kubectl get pods -n default

# Pokazuje serwisy tylko z przestrzeni nazw 'default'
services-default:
	kubectl get services -n default

# Pokazuje deploymenty tylko z przestrzeni nazw 'default'
deployments-default:
	kubectl get deployments -n default

set-active-namespace:
	kubectl config view --minify | grep namespace

get-active-namespace:
	kubectl config view --minify | grep namespace

#dodać komende ktore tworzy namespace
#dodać komende do deploymentu
