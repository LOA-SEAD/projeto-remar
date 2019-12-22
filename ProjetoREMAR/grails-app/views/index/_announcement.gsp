<%@ page import="br.ufscar.sead.loa.remar.Announcement" %>
<li>
    <img src="images/slider/slider${i}.png">
    <div class="caption left-align">
        <h3 class="alternative-text">
            ${announcement.getTitle()}
        </h3>
        <h5 class="alternative-text">
            ${raw(announcement.getBody())}
        </h5>
    </div>
</li>