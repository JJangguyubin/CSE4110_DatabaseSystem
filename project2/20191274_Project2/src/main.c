#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>

// 데이터베이스 연결 정보 설정 (본인의 환경에 맞게 수정하세요)
#define DB_HOST "localhost"
#define DB_USER "root"
#define DB_PASS "6339" // 실제 MySQL 비밀번호로 변경
#define DB_NAME "auto_company"
#define DB_PORT 3306

// 에러 발생 시 처리하는 헬퍼 함수
void finish_with_error(MYSQL *conn)
{
    fprintf(stderr, "\n[Database Error] %s\n", mysql_error(conn));
    mysql_close(conn);
    exit(1);
}

// 쿼리를 실행하고 결과를 표 형태로 출력하는 공통 함수
void execute_and_print_query(MYSQL *conn, const char *query, const char *title)
{
    printf("\n========================================================================================\n");
    printf(" %s\n", title);
    printf("========================================================================================\n");

    if (mysql_query(conn, query))
    {
        fprintf(stderr, "Query Execution Failed: %s\n", mysql_error(conn));
        return;
    }

    MYSQL_RES *result = mysql_store_result(conn);
    if (result == NULL)
    {
        if (mysql_field_count(conn) == 0)
        {
            // 결과셋이 없는 쿼리(INSERT, UPDATE 등)의 경우
            printf("Query executed successfully. %llu rows affected.\n", mysql_affected_rows(conn));
        }
        else
        {
            fprintf(stderr, "Result Store Failed: %s\n", mysql_error(conn));
        }
        return;
    }

    int num_fields = mysql_num_fields(result);
    MYSQL_ROW row;
    MYSQL_FIELD *field;

    // 1. 헤더(컬럼명) 출력
    while ((field = mysql_fetch_field(result)))
    {
        printf("%-20s ", field->name);
    }
    printf("\n");
    for (int i = 0; i < num_fields; i++)
    {
        printf("-------------------- ");
    }
    printf("\n");

    // 2. 데이터(행) 출력
    int row_count = 0;
    while ((row = mysql_fetch_row(result)))
    {
        for (int i = 0; i < num_fields; i++)
        {
            printf("%-20s ", row[i] ? row[i] : "NULL");
        }
        printf("\n");
        row_count++;
    }

    if (row_count == 0)
    {
        printf("No records found matching the criteria.\n");
    }
    else
    {
        printf("\nTotal %d row(s) returned.\n", row_count);
    }

    // 3. 메모리 해제
    mysql_free_result(result);
}

// ======================= [ 7가지 핵심 쿼리 함수 ] =======================

void run_query1_sales_trends(MYSQL *conn)
{
    const char *query =
        "SELECT b.name AS brand_name, YEAR(s.date) AS sales_year, MONTH(s.date) AS sales_month, "
        "WEEK(s.date) AS sales_week, c.gender, "
        "CASE "
        "  WHEN c.annual_income < 30000 THEN 'Low' "
        "  WHEN c.annual_income BETWEEN 30000 AND 60000 THEN 'Middle' "
        "  ELSE 'High' "
        "END AS income_range, "
        "COUNT(s.sales_id) AS total_sales_volume, SUM(s.sale_price) AS total_sales_revenue "
        "FROM sales s "
        "JOIN vehicle v ON s.VIN = v.VIN "
        "JOIN model m ON v.model_id = m.model_id "
        "JOIN brand b ON m.brand_id = b.brand_id "
        "JOIN customer c ON s.customer_id = c.customer_id "
        "WHERE s.date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR) "
        "GROUP BY b.brand_id, b.name, sales_year, sales_month, sales_week, c.gender, income_range "
        "ORDER BY brand_name, sales_year, sales_month, sales_week;";
    execute_and_print_query(conn, query, "Query 1: Sales Trends (Past 3 Years)");
}

void run_query2_defective_part(MYSQL *conn)
{
    const char *query =
        "SELECT v.VIN, c.name AS customer_name, c.phone AS customer_phone "
        "FROM supplier s "
        "JOIN supplier_plant spl ON s.supplier_id = spl.supplier_id "
        "JOIN supplies sp ON sp.supplier_id = spl.supplier_id AND sp.supplier_plant_name = spl.name "
        "JOIN part p ON sp.part_id = p.part_id "
        "JOIN model m ON sp.model_id = m.model_id "
        "JOIN vehicle v ON m.model_id = v.model_id "
        "JOIN sales sl ON v.VIN = sl.VIN "
        "JOIN customer c ON sl.customer_id = c.customer_id "
        "WHERE s.name = 'Getrag' AND p.name = 'transmission' "
        "AND spl.name = 'Getrag_Plant_1' AND sp.supply_date BETWEEN '2023-01-01' AND '2024-12-31';";
    execute_and_print_query(conn, query, "Query 2: Defective Part Tracking (Getrag Transmissions)");
}

void run_query3_top_brands_revenue(MYSQL *conn)
{
    const char *query =
        "SELECT b.name AS brand_name, SUM(s.sale_price) AS total_revenue "
        "FROM sales s "
        "JOIN vehicle v ON s.VIN = v.VIN "
        "JOIN model m ON v.model_id = m.model_id "
        "JOIN brand b ON m.brand_id = b.brand_id "
        "WHERE s.date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) "
        "GROUP BY b.brand_id, b.name "
        "ORDER BY total_revenue DESC LIMIT 2;";
    execute_and_print_query(conn, query, "Query 3: Top 2 Brands by Revenue (Past 1 Year)");
}

void run_query4_top_brands_units(MYSQL *conn)
{
    const char *query =
        "SELECT b.name AS brand_name, COUNT(s.sales_id) AS total_unit_sales "
        "FROM sales s "
        "JOIN vehicle v ON s.VIN = v.VIN "
        "JOIN model m ON v.model_id = m.model_id "
        "JOIN brand b ON m.brand_id = b.brand_id "
        "WHERE s.date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) "
        "GROUP BY b.brand_id, b.name "
        "ORDER BY total_unit_sales DESC LIMIT 2;";
    execute_and_print_query(conn, query, "Query 4: Top 2 Brands by Unit Sales (Past 1 Year)");
}

void run_query5_seasonal_sales(MYSQL *conn)
{
    const char *query =
        "SELECT MONTH(s.date) AS best_selling_month, COUNT(s.sales_id) AS total_unit_sales "
        "FROM sales s "
        "JOIN vehicle v ON s.VIN = v.VIN "
        "JOIN model m ON v.model_id = m.model_id "
        "JOIN model_body_style mbs ON m.model_id = mbs.model_id "
        "WHERE mbs.body_style = 'convertible' "
        "GROUP BY best_selling_month "
        "ORDER BY total_unit_sales DESC LIMIT 1;";
    execute_and_print_query(conn, query, "Query 5: Seasonal Sales Patterns (Convertibles)");
}

void run_query6_dealer_inventory(MYSQL *conn)
{
    const char *query =
        "SELECT d.dealer_id, d.name, AVG(DATEDIFF(s.date, v.arrival_date)) AS avg_inventory_time_days "
        "FROM dealer d "
        "JOIN vehicle v ON d.dealer_id = v.dealer_id "
        "JOIN sales s ON v.VIN = s.VIN "
        "GROUP BY d.dealer_id, d.name "
        "ORDER BY avg_inventory_time_days DESC LIMIT 1;";
    execute_and_print_query(conn, query, "Query 6: Dealer Inventory Efficiency (Longest Avg Time)");
}

void run_query7_supplier_coverage(MYSQL *conn)
{
    const char *query =
        "SELECT s.supplier_id, s.name, COUNT(DISTINCT sp.model_id) AS distinct_model_count "
        "FROM supplier s "
        "JOIN supplier_plant spl ON s.supplier_id = spl.supplier_id "
        "JOIN supplies sp ON sp.supplier_id = spl.supplier_id AND sp.supplier_plant_name = spl.name "
        "GROUP BY s.supplier_id, s.name "
        "ORDER BY distinct_model_count DESC LIMIT 1;";
    execute_and_print_query(conn, query, "Query 7: Supplier Coverage (Most Distinct Models)");
}

// =========================================================================

void display_menu()
{
    printf("\n");
    printf("====================================================\n");
    printf("      Automobile Company Database Dashboard         \n");
    printf("====================================================\n");
    printf("  1. Sales Trends (Past 3 Years)\n");
    printf("  2. Defective Part Tracking\n");
    printf("  3. Top 2 Brands by Revenue\n");
    printf("  4. Top 2 Brands by Unit Sales\n");
    printf("  5. Seasonal Sales Patterns (Convertible)\n");
    printf("  6. Dealer Inventory Efficiency\n");
    printf("  7. Supplier Coverage\n");
    printf("  0. Exit Application\n");
    printf("====================================================\n");
    printf("Enter your choice (0-7): ");
}

int main()
{
    // MySQL 초기화 및 연결
    MYSQL *conn = mysql_init(NULL);
    if (conn == NULL)
    {
        fprintf(stderr, "mysql_init() failed\n");
        return EXIT_FAILURE;
    }

    printf("Connecting to database...\n");
    if (mysql_real_connect(conn, DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT, NULL, 0) == NULL)
    {
        finish_with_error(conn);
    }
    printf("Successfully connected to MySQL Database '%s'!\n", DB_NAME);

    // 메뉴 루프 실행
    int choice = -1;
    char input_buffer[100];

    while (1)
    {
        display_menu();

        // 입력 받기
        if (fgets(input_buffer, sizeof(input_buffer), stdin) != NULL)
        {
            choice = atoi(input_buffer);
        }
        else
        {
            continue;
        }

        switch (choice)
        {
        case 1:
            run_query1_sales_trends(conn);
            break;
        case 2:
            run_query2_defective_part(conn);
            break;
        case 3:
            run_query3_top_brands_revenue(conn);
            break;
        case 4:
            run_query4_top_brands_units(conn);
            break;
        case 5:
            run_query5_seasonal_sales(conn);
            break;
        case 6:
            run_query6_dealer_inventory(conn);
            break;
        case 7:
            run_query7_supplier_coverage(conn);
            break;
        case 0:
            printf("\nExiting the application. Goodbye!\n");
            mysql_close(conn);
            return EXIT_SUCCESS;
        default:
            printf("\n[Warning] Invalid choice! Please enter a number between 0 and 7.\n");
        }
    }

    return EXIT_SUCCESS;
}