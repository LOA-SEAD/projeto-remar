<br />
<div class="row">
    <div id="swiper-${userId}" class="swiper-container my-max-height">
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
                <div class="data-item colored">
                    <span>${data.enunciado}</span>
                </div>

                <!--
                    <g:if test="${data.resposta == data.alternativaa}">
                        <i class="material-icons">check</i>
                    </g:if>
                -->

                <g:if test="${data.respostacerta == "A"}">
                    <div class="data-item green-bordered">
                </g:if>
                <g:else>
                    <div class="data-item">
                </g:else>
                        <g:if test="${data.resposta == "A"}">
                            <i class="material-icons">
                                <g:if test="${data.resposta == data.respostacerta}">
                                    check
                                </g:if>
                                <g:else>
                                    close
                                </g:else>
                            </i>
                        </g:if>

                        <span>${data.alternativaa}</span>
                    </div>

                <g:if test="${data.respostacerta == "B"}">
                    <div class="data-item green-bordered">
                </g:if>
                <g:else>
                    <div class="data-item">
                </g:else>
                        <g:if test="${data.resposta == "B"}">
                            <i class="material-icons">
                                <g:if test="${data.resposta == data.respostacerta}">
                                    check
                                </g:if>
                                <g:else>
                                    close
                                </g:else>
                            </i>
                        </g:if>

                        <span>${data.alternativab}</span>
                    </div>

                <g:if test="${data.respostacerta == "C"}">
                    <div class="data-item green-bordered">
                </g:if>
                <g:else>
                    <div class="data-item">
                </g:else>
                        <g:if test="${data.resposta == "C"}">
                            <i class="material-icons">
                                <g:if test="${data.resposta == data.respostacerta}">
                                    check
                                </g:if>
                                <g:else>
                                    close
                                </g:else>
                            </i>
                        </g:if>

                        <span>${data.alternativac}</span>
                    </div>

                <g:if test="${data.respostacerta == "D"}">
                    <div class="data-item green-bordered">
                </g:if>
                <g:else>
                    <div class="data-item">
                </g:else>
                        <g:if test="${data.resposta == "D"}">
                            <i class="material-icons">
                                <g:if test="${data.resposta == data.respostacerta}">
                                    check
                                </g:if>
                                <g:else>
                                    close
                                </g:else>
                            </i>
                        </g:if>

                        <span>${data.alternativad}</span>
                    </div>

                <div class="data-item">
                    <span>${data.timestamp}</span>
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
            slidesPerView: 2,
            spaceBetween: 5,
            centeredSlides: true,
            paginationHide: true,
            freeMode: true,
            setWrapperSize: 600,
        });
    }, 500);
</script>