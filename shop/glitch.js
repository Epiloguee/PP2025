document.addEventListener("DOMContentLoaded", function () {
    const orderButton = document.querySelector("#order-button");

    if (!orderButton) return;

    orderButton.addEventListener("click", function () {
        initiateChaos();
    });
});

function initiateChaos() {
    playChaosSounds();
    startChaosEffects();
}

function playChaosSounds() {
    const audio = new Audio("sounds/Paranoia_Dance.mp3");
    audio.loop = true;
    audio.play();
}

function startChaosEffects() {
    document.body.classList.add("chaos-mode");
    const elements = [...document.body.children];

    elements.forEach((el, index) => {
        if (el.tagName !== "SCRIPT" && el.tagName !== "STYLE" && el.tagName !== "LINK") {
            const originalRect = el.getBoundingClientRect(); // Получаем текущие координаты элемента

            // Создаем 4 копии вместо 1
            for (let i = 0; i < 4; i++) {
                const clone = el.cloneNode(true);
                clone.classList.add("clone");
                document.body.appendChild(clone);

                // Определяем начальную позицию клона рядом с оригиналом
                positionCloneNearOriginal(clone, originalRect, i);

                // Анимируем каждую копию
                animateElement(clone, index, i);
                animateInnerElements(clone);
            }

            // Анимируем оригинальный элемент
            animateElement(el, index, 0);
            animateInnerElements(el);
        }
    });
}

// Размещаем клон рядом с оригиналом в случайном направлении
function positionCloneNearOriginal(clone, originalRect, index) {
    const offsets = [
        { x: -50, y: -50 }, // Влево-вверх
        { x: 50, y: -50 },  // Вправо-вверх
        { x: -50, y: 50 },  // Влево-вниз
        { x: 50, y: 50 }    // Вправо-вниз
    ];

    clone.style.position = "absolute";
    clone.style.left = `${originalRect.left + offsets[index].x}px`;
    clone.style.top = `${originalRect.top + offsets[index].y}px`;
}

// Двигаем элементы по экрану в виде "взрыва"
function animateElement(el, index, cloneIndex) {
    const maxDistance = 250; // Максимальная дальность полета
    const randomXDistance = Math.random() * maxDistance * (Math.random() > 0.5 ? 1 : -1); // Случайная дальность по X
    const randomYDistance = Math.random() * maxDistance * (Math.random() > 0.5 ? 1 : -1); // Случайная дальность по Y
    const randomRotation = Math.random() > 0.5 ? 360 : -360;

    gsap.to(el, {
        duration: 1 + Math.random() * 3, // Случайная скорость движения
        x: randomXDistance,
        y: randomYDistance,
        rotation: randomRotation, // Вращение в случайную сторону
        ease: "power1.inOut",
        repeat: -1, // Бесконечное движение
        yoyo: true,
        delay: Math.random() * 2, // Случайная задержка
    });
}

// Вращаем внутренние элементы
function animateInnerElements(el) {
    const innerElements = el.querySelectorAll("*");

    innerElements.forEach((child) => {
        gsap.to(child, {
            duration: 1 + Math.random() * 2,
            rotation: 360,
            ease: "linear",
            repeat: -1
        });
    });
}
