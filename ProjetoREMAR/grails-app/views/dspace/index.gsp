<%--
Created by IntelliJ IDEA.
User: lucasbocanegra
Date: 07/06/16
Time: 08:58
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>dspace</title>
</head>
<body>
    <h1>${token}</h1>

    <h2>comunidades</h2>
    <p>Id: ${communities.id}</p>
    <p>Name: ${communities.name}</p>
    <p>Logo: ${communities.logo}</p>
    <p>Handle: ${communities.handle}</p>
    <p>Link: ${communities.link}</p>
    <p>CopyrightText: ${communities.copyrightText}</p>
    <p>Type: ${communities.type}</p>
    <p>ParentCommunity: ${communities.parentCommunity}</p>
    %{--${communities}--}%
    %{--<g:each in="${communities}" var="community">--}%
        %{--<div>--}%
            %{--${community}--}%
            %{--<br>--}%
            %{--<p>Id: ${community.id}</p>--}%
            %{--<p>Logo: ${community.logo}</p>--}%
            %{--<p>Handle: ${community.handle}</p>--}%
            %{--<p>Link: ${community.link}</p>--}%
            %{--<p>CopyrightText: ${community.copyrightText}</p>--}%
            %{--<p>Type: ${community.type}</p>--}%
            %{--<p>ParentCommunity: ${community.parentCommunity}</p>--}%
        %{--</div>--}%
        %{--<br><br>--}%
    %{--</g:each>--}%

    <h2>subComunidades</h2>
    <p>${subCommunities}</p>

    <hr>
    <h2>coleções</h2>
    ${collections}

    <hr>
    <h2>itens</h2>
    ${items}

    <hr>
    <h2>bitstreams</h2>
    ${bitstreams}

    <hr>
    <h2>reports</h2>
    ${reports}

</body>
</html>
</body>
</html>