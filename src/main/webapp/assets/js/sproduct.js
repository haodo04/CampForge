const mainImg = document.getElementById("MainImg");
const thumbs = Array.from(document.querySelectorAll("#thumbList .small-img"));
const btnPrev = document.querySelector(".sp-prev");
const btnNext = document.querySelector(".sp-next");

const mainSrc = mainImg.getAttribute("src");
const slideUrls = [mainSrc, ...thumbs.map(t => t.getAttribute("src"))];

let current = 0;

function render(idx) {
    current = (idx + slideUrls.length) % slideUrls.length;
    mainImg.src = slideUrls[current];

    thumbs.forEach(t => t.classList.remove("active"));
    if (current > 0) thumbs[current - 1].classList.add("active");
}

thumbs.forEach((t, i) => t.addEventListener("click", () => render(i + 1)));

if (btnPrev) btnPrev.addEventListener("click", () => render(current - 1));
if (btnNext) btnNext.addEventListener("click", () => render(current + 1));

mainImg.addEventListener("click", () => {
    if (slideUrls.length > 1) render(current + 1);
});

render(0);

