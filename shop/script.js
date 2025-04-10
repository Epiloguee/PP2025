let cropper;

function handleFileSelect(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function (e) {
            // Создаём временный элемент изображения для предварительного просмотра
            const img = document.createElement('img');
            img.src = e.target.result;
            img.id = 'image-to-crop';

            // Вставляем это изображение в контейнер для обрезки
            const previewContainer = document.createElement('div');
            previewContainer.classList.add('image-crop-container');
            previewContainer.appendChild(img);

            // Добавляем кнопку сохранения
            const saveButton = document.createElement('button');
            saveButton.textContent = 'Сохранить';
            saveButton.classList.add('save-button');
            saveButton.onclick = function () {
                const canvas = cropper.getCroppedCanvas();
                canvas.toBlob(function (blob) {
                    const formData = new FormData();
                    formData.append('profile_image', blob);
                    formData.append('action', 'upload');

                    fetch('profile.php', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => response.text())  // Сначала получаем текст, чтобы проверить, что вернул сервер
                    .then(text => {
                        console.log('Ответ от сервера:', text);  // Выводим в консоль
                        try {
                            const data = JSON.parse(text);  // Пробуем преобразовать в JSON
                            if (data.success) {
                                window.location.reload();  // Перезагружаем страницу, если загрузка прошла успешно
                            } else {
                                alert(data.message);  // Показываем сообщение об ошибке
                            }
                        } catch (error) {
                            console.error('Ошибка при парсинге JSON:', error);
                            alert('Ошибка при загрузке изображения: ' + error.message);
                        }
                    })
                    .catch(error => {
                        console.error('Ошибка при загрузке изображения:', error);
                        alert('Что-то пошло не так при загрузке изображения.');
                    });
                    
                });
            };
            previewContainer.appendChild(saveButton);
            document.body.appendChild(previewContainer);

            // Инициализация Cropper.js
            cropper = new Cropper(img, {
                aspectRatio: 1,
                viewMode: 2,
                autoCropArea: 0.8,
                responsive: true
            });
        };
        reader.readAsDataURL(file);
    }
}
