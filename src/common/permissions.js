'use strict';

import { allow, deny, shield, rule, and, or } from 'graphql-shield';

const is_user = rule('is_user', { cache: 'contextual' })(async (parent, args, context, info) => {
    if (context && context.user) {
        let user = context.user;
        if (!Array.isArray(user.roles)) return false;
        if (user.roles.includes('can_read') && user.roles.includes('can_report')) {
            return true;
        } else {
            return new Error('Ошибка доступа: у вас нет права пользоваться системой');
        }
    } else {
        return new Error('Ошибка доступа: войдите в систему чтобы продолжить');
    }
});

const is_admin = rule('is_admin', { cache: 'contextual' })(async (parent, args, context, info) => {
    let user = context.user;
    if (!user) return false;
    if (!Array.isArray(user.roles)) return false;
    if (user.roles.includes('can_read') && user.roles.includes('can_report') && user.roles.includes('can_edit') && user.roles.includes('can_add')) {
        return true;
    } else {
        return new Error('Ошибка доступа: у вас нет прав администратора');
    }
});

const is_editor = rule('is_editor', { cache: 'contextual' })(async (parent, args, context, info) => {
    let user = context.user;
    if (!user) return false;
    if (!Array.isArray(user.roles)) return false;
    if (user.roles.includes('can_read') && user.roles.includes('can_report') && user.roles.includes('can_edit')) {
        return true;
    } else {
        return new Error('Ошибка доступа: у вас нет права пользоваться системой');
    }
});

export const permissions = shield(
    {
        Query: {
            '*': deny,
            'get_catalog': is_user,
            'get_user': is_user,
        },
        Mutation: {
            '*': deny,
            'edit_catalog_entry': or(is_editor, is_admin),
            'add_catalog_entry': is_admin,
            'terminate_catalog_entry': or(is_editor, is_admin),
            'unterminate_catalog_entry': or(is_editor, is_admin),
        },
    },
    {
        fallbackError: 'Ошибка доступа: у вас недостаточно прав',
        allowExternalErrors: true,
    }
);