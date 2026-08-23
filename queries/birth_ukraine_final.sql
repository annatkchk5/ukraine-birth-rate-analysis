SELECT 
    CAST(EXTRACT(YEAR FROM "Період") AS text) AS year,
    "Територіальний розріз" AS region,
    MAX("Кількість_народжених") AS births --  SUM на MAX для накопичувальних даних
FROM births_ukraine_monthly_fixed
WHERE "Вік матері" = 'Усього'
  AND "Тип місцевості" = 'Загалом'
  AND EXTRACT(YEAR FROM "Період") < 2022
  AND "Територіальний розріз" NOT IN ('Україна')
GROUP BY EXTRACT(YEAR FROM "Період"), "Територіальний розріз"

UNION ALL

-- Дані Мін'юсту вже є річними, тому їх просто виводимо
SELECT 
    CAST("Рік" AS text) AS year,
    "Регіон" AS region,
    "Кількість_народжених" AS births
FROM minjust_births
WHERE "Регіон" NOT IN ('ВСЬОГО', 'Всього')
  AND "Регіон" IS NOT NULL

ORDER BY region ASC, year ASC;