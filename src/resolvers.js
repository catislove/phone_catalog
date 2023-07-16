import pg from 'pg';
import format from 'pg-format';
import excel from 'exceljs';
import csv from 'fast-csv';
import { writeToString } from 'fast-csv';
import builder from 'xmlbuilder';
const Client = pg.Client;
const client = new Client(process.env.DB_URL);
await client.connect();

const headers = [
    {
        key: 'last_name',
        header: 'Фамилия',
        width: 45,
    },
    {
        key: 'first_name',
        header: 'Имя',
        width: 30,
    },
    {
        key: 'middle_name',
        header: 'Отчество',
        width: 30,
    },
    {
        key: 'gender',
        header: 'Пол',
        width: 15,
    },
    {
        key: 'birthdate',
        header: 'Дата рождения',
        width: 15,
    },
    {
        key: 'phone_number',
        header: 'Номер телефона',
        width: 30,
    },
    {
        key: 'mail',
        header: 'Почтовый адрес',
        width: 45,
    },
    {
        key: 'address',
        header: 'Адрес',
        width: 45,
    },
];

export function get_client() {
    return client;
}
export async function get_catalog(parent, { order, search }, context, info) {
    let search_field = search ? search.field : null;
    let order_field = order ? order.field : null;
    let text = format.withArray(
        'SELECT * from phone_catalog' +
            (search ? ` WHERE %I LIKE '${search.value}'` : '') +
            (order ? ` ORDER BY %I ${order.order}` : ''),
        search_field ?? order_field,
        order_field
    );
    let res = await client.query(text, []);
    return res.rows;
}


export async function add_catalog_entry(parent, { entry }, context, info) {
    let keys = Object.keys(entry).join(', ');
    let values = Object.values(entry);
    let res = await client.query(format(`INSERT INTO phone_catalog (${keys}) VALUES (%L) RETURNING *`, values), []);
    return res.rows[0];
}

export async function edit_catalog_entry(parent, { id, entry }, context, info) {
    let pairs = Object.keys(entry)
        .map((x) => format(`${x} = %L`, entry[x]))
        .join(', ');
    let res = await client.query(`UPDATE phone_catalog SET ${pairs} WHERE id = $1 RETURNING *`, [id]);
    return res.rows[0];
}

export async function terminate_catalog_entry(parent, { id }, context, info) {
    let res = await client.query(`UPDATE phone_catalog SET termination_date = NOW() WHERE id = $1 RETURNING *`, [id]);
    return res.rows[0];
}

export async function unterminate_catalog_entry(parent, { id }, context, info) {
    let res = await client.query(`UPDATE phone_catalog SET termination_date = null WHERE id = $1 RETURNING *`, [id]);
    return res.rows[0];
}

export async function get_user(parent, args, context_value, info) {
    let user = context_value.user;
    if (args['id'] && args['id'] != user.id) {
        // TODO: probably check admin role and allow to get other users info
        throw new GraphQLError('Недостаточно прав', {
            extensions: {
                code: 'ACCESSDENIED',
                http: { status: 403 },
            },
        });
    }

    return user;
}

async function get_report_separated(delimiter) {
    let headers_names = headers.map((x) => x.header);
    let res = await client.query(`SELECT * FROM phone_catalog`, []);
    let data = headers_names.join(delimiter);
    data += '\r\n';

    data += await csv.writeToString(res.rows, { delimiter: delimiter });
    return data;
}

async function get_report_xls() {
    let res = await client.query(`SELECT * FROM phone_catalog`, []);
    let data = res.rows;
    const workbook = new excel.Workbook();
    let worksheet = workbook.addWorksheet('Телефонный справочник');

    worksheet.columns = headers;

    worksheet.getRow(1).eachCell((cell) => {
        cell.font = { bold: true };
        cell.alignment = { vertical: 'middle', horizontal: 'center', wrapText: true };
    });
    worksheet.addRows(data);

    let result_data = await workbook.xlsx.writeBuffer();

    return result_data;
}

async function get_report_xml() {
    let root = builder.create('data');
    let res = await client.query(`SELECT * FROM phone_catalog`, []);
    for (let i = 0; i < res.rows.length; i++) {
        let item = root.ele('row');
        headers.forEach((x) => {
            if (res.rows[i][x.key]) item.ele(x.key, res.rows[i][x.key]);
        });
    }

    let data = root.end({ pretty: true });
    return data;
}

export async function get_catalog_report(format) {
    switch (format) {
        case 'csv':
            return await get_report_separated(',');
        case 'xlsx':
            return await get_report_xls();
        case 'tsv':
            return await get_report_separated('\t');
        case 'xml':
            return await get_report_xml();
    }
}

