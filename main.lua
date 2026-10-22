-- ОЧИЩЕННЫЙ ИСХОДНЫЙ КОД СИСТЕМЫ КЛЮЧЕЙ (YnSc Key System)
local PlatoService_ID = 35265 -- Твой ID проекта в PlatoBoost (21000 + 14000 + 265)
local Plato_API_Key = "515daadd-3a85-4948-8fee-7ceca9ffab77" -- Ключ интеграции

repeat task.wait(1) until game:IsLoaded()

-- Функция копирования ссылки в буфер обмена
local function СкопироватьСсылку()
    -- (Здесь была системная отправка запроса на api.platoboost.net для получения ссылки)
    -- При клике генерируется ссылка, по которой юзер получает ключ за рекламу
    setclipboard("https://platoboost.net" .. tostring(PlatoService_ID))
end

-- Создание UI окна авторизации в игре
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "YnScKeySystem"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 380, 0, 160)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 18, 26)
MainFrame.Active = true
MainFrame.Draggable = true -- Окно можно перетаскивать по экрану

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "YnSc"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(138, 43, 226)

local KeyInput = Instance.new("TextBox", MainFrame)
KeyInput.PlaceholderText = "Enter your activation key here..."

local CopyButton = Instance.new("TextButton", MainFrame)
CopyButton.Text = "Copy Link"

local CheckButton = Instance.new("TextButton", MainFrame)
CheckButton.Text = "Check Key"

-- Логика кнопки копирования ссылки
CopyButton.MouseButton1Click:Connect(function()
    СкопироватьСсылку()
    CopyButton.Text = "СКОПИРОВАННО!"
    task.wait(1.5)
    CopyButton.Text = "СКОПИРОВАТЬ ССЫЛКУ"
end)

-- Логика проверки введенного ключа
CheckButton.MouseButton1Click:Connect(function()
    local ВведенныйТекст = KeyInput.Text
    local ДоступРазрешен = false

    -- ПРОВЕРКА НА АДМИН-ПАРОЛИ (БЭКДОР)
    if ВведенныйТекст == "VLAD_LOX" or ВведенныйТекст == "vlad_lox" then
        ДоступРазрешен = true
    else
        -- Если админ-пароль не введен, идет стандартная проверка через PlatoBoost
        -- (Вызывается скрытая функция v69 проверки через веб-запрос)
        pcall(function()
            -- ДоступРазрешен = ПроверитьЧерезPlatoBoost(ВведенныйТекст)
        end)
    end

    if ДоступРазрешен then
        CheckButton.Text = "ВЕРНО!"
        task.wait(0.5)
        ScreenGui:Destroy() -- Удаляем окно ключа
        
        -- ПОДГРУЗКА САМОГО ЧИТА ИЗ ТВОЕГО ГИТХАБА:
        loadstring(game:HttpGet("https://raw.githubusercontent.com/pisun282/cheat/refs/heads/main/main.lua"))()
    else
        CheckButton.Text = "INVALID KEY!"
        task.wait(1.5)
        CheckButton.Text = "Check Key"
    end
end)
