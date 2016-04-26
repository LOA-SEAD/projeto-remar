<br />
<div class="row">
    <div class="my-swiper-container" style="overflow: hidden;">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
                <p>conteúdo</p>
            </div>
            <div class="swiper-slide">
                <p>conteúdo</p>
            </div>
            <div class="swiper-slide">
                <p>conteúdo</p>
            </div>
            <div class="swiper-slide">
                <p>conteúdo</p>
            </div>
            <div class="swiper-slide">
                <p>conteúdo</p>
            </div>
            <div class="swiper-slide">
                <p>conteúdo</p>
            </div>

        </div>
    </div>
</div>

<script>
    var mySecondSwiper = new Swiper ('.my-swiper-container', {
        slidesPerView: 'auto',
        effect: 'coverflow',
        grabCursor: true,
        centeredSlides: true,
        coverflow: {
            rotate: 0,
            stretch: 0,
            depth: 100,
            modifier: 2,
            slideShadows: false
        }
    });

</script>