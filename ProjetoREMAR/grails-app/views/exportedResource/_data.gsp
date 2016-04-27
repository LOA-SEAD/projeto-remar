<br />
<div class="row">
    <div id="swiper-${userId}" class="swiper-container">
        <!-- Additional required wrapper -->
        <div class="swiper-wrapper">
        <!-- Slides -->
        <g:each in="${dataCollection}" var="data">
            <g:if test="${data.resposta == data.respostacerta}">
                <div class="swiper-slide data-container data-right">
           </g:if>
            <g:else>
                <div class="swiper-slide data-container data-wrong">
            </g:else>
                <div class="row">
                    <div class="col s12">${data.enunciado}</div>
                </div>
            </div>
        </g:each>
        </div>
    </div>
</div>

<script>
    setTimeout(function() {
        new Swiper ('#swiper-${userId}', {
            // Optional parameters
            direction: 'horizontal',
            slidesPerView: 4,
            spaceBetween: 5,
            centeredSlides: true,
            paginationHide: true,
            freeMode: true,
            setWrapperSize: 600,
        });
    }, 500);
</script>