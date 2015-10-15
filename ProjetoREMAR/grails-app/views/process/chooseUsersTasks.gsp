<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="dashboard">
    <title>Atribuição de tarefas</title>
</head>
<body>
    <g:each in="${tasks}" var="task">
        <div class="col s12 m6 l4">
            <div class="card z-depth-1-half">
                <div class="card-header red">
                    <div class="card-title">
                        <h5 class="task-name truncate">${task.name}</h5>
                        <p class="task-status">Sem usuário responsável</p>
                        <img class="circle profile-picture right" src="/images/avatars/female.png?v=2"/>
                    </div>
                </div>
                <div class="card-content">
                    <p class="text-justify">${task.description}</p>
                </div> <!-- card-content -->
            </div> <!-- card -->
        </div> <!-- col -->
    </g:each>
</body>
</html>