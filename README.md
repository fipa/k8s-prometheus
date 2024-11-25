# Acciones manuales necesarias:

1. Habilitar la redirección de puerto del localhost a la api.
    
    `microk8s kubectl port-forward <nombre del pod de la api> 3000:3000`

2. Crear usuario en la interfaz de management de Rabbit.
Para eso, obtener la IP del pod.

    `microk8s kubectl describe <nombre del pod de rabbit> |grep IP`

    Visitar <dirección IP>:15672, agregar el usuario guest:guest y habilitar virtual host '/'.