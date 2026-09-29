-- Блок 1. Создаю таблицу питомцев
CREATE TABLE animals (
    id UUID PRIMARY KEY,                 
    name VARCHAR(100) NOT NULL,          
    species VARCHAR(50) NOT NULL,        
    birth_date DATE,                     
    status VARCHAR(30) NOT NULL,         
    arrival_date DATE NOT NULL           
);

-- создаю таблицу клиентов
CREATE TABLE clients (
    id UUID PRIMARY KEY,                 
    full_name VARCHAR(255) NOT NULL,     
    phone VARCHAR(20) NOT NULL,          
    email VARCHAR(100),                  
    is_blacklisted BOOLEAN DEFAULT FALSE 
);




-- Блок 2. Создаю таблицу заявок на усыновление 
CREATE TABLE adoption_requests (
    id UUID PRIMARY KEY,                 
    client_id UUID NOT NULL,             
    animal_id UUID NOT NULL,             
    status VARCHAR(50) NOT NULL,         
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    
-- настраиваю связи с первыми двумя таблицами
    FOREIGN KEY (client_id) REFERENCES clients(id),
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);




-- Блок 3. Добавляю тестового питомца 
INSERT INTO animals (id, name, species, birth_date, status, arrival_date)
VALUES ('a1111111-1111-1111-1111-111111111111', 'Барсик', 'Кот', '2024-05-10', 'Ищет дом', '2026-01-15');

-- добавляю двух тестовых клиентов
INSERT INTO clients (id, full_name, phone, email, is_blacklisted)
VALUES 
('c2222222-2222-2222-2222-222222222222', 'Иванов Иван Иванович', '+79991112233', 'ivan@mail.ru', FALSE),
('c3333333-3333-3333-3333-333333333333', 'Петров Пётр Петрович', '+79996667788', 'petr_bad@mail.ru', TRUE);

-- создаю заявки с уникальным id для каждой
INSERT INTO adoption_requests (id, client_id, animal_id, status)
VALUES 
('04444444-4444-4444-4444-444444444444', 'c2222222-2222-2222-2222-222222222222', 'a1111111-1111-1111-1111-111111111111', 'Новая'),
('05555555-5555-5555-5555-555555555555', 'c3333333-3333-3333-3333-333333333333', 'a1111111-1111-1111-1111-111111111111', 'Новая');


-- Блок 4. Тестирую вывод текущих заявок
SELECT 
    r.id AS request_id,
    c.full_name AS client_name,
    c.is_blacklisted,
    a.name AS animal_name,
    r.status AS request_status
FROM adoption_requests r
JOIN clients c ON r.client_id = c.id
JOIN animals a ON r.animal_id = a.id;
