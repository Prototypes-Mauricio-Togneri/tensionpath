import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:tensionbase/utils/log.dart';

class ErrorHandler {
  static Future process(
    Object exception,
    ErrorType type,
  ) {
    _logError(
      'Error Type: ${type.name} => $exception',
      exception,
      null,
    );

    _logAnalytics(type, exception);

    return FirebaseCrashlytics.instance.recordError(
      exception,
      null,
      reason: type.name,
      fatal: false,
    );
  }

  static Future onUncaughtError(Object exception, StackTrace stackTrace) {
    _logError(
      'Uncaught Error',
      exception,
      stackTrace,
    );

    _logAnalytics(ErrorType.uncaught_error, exception);

    return FirebaseCrashlytics.instance.recordError(
      exception,
      stackTrace,
      fatal: true,
    );
  }

  static void _logError(
    dynamic message,
    dynamic error,
    StackTrace? stackTrace,
  ) {
    try {
      Log.error(message, error, stackTrace);
    } catch (e) {
      debugPrint(error.toString());
      debugPrint('Cannot log error in console');
    }
  }

  static void _logAnalytics(ErrorType type, Object exception) {
    // TODO(momo): implement
    /*try {
      Analytics.error(type, exception);
    } catch (e) {
      debugPrint(exception.toString());
      debugPrint('Cannot log error in Firebase Analytics');
    }*/
  }
}

enum ErrorType {
  uncaught_error,
  reload_token,
  http_request,
  local_auth,
  field_not_found,
  re_authentication,
  sign_in,
  sign_up,
  confirm_multi_factor,
  start_multi_factor_setup,
  confirm_multi_factor_setup,
  send_email_confirmation,
  send_password_email,
  send_sms_code,
  reset_password,
  set_new_password,
  update_password,
  verify_email,
  start_phone_update,
  apply_phone_update,
  upload_user_avatar,
  update_user,
  upload_bank_transaction_document,
  upload_payment_submission_document,
  open_file,
  download_file,
  delete_file,
  create_workspace,
  update_workspace,
  upload_workspace_avatar,
  update_membership,
  delete_membership,
  create_invitation,
  delete_invitation,
  reload_user,
  check_initial_link,
  fetch_remote_config,
  parsing_document,
  executing_query,
  loading_memberships,
  loading_invitations,
  loading_bank_accounts,
  loading_bank_transactions,
  loading_consents,
  loading_balance_history,
  revoke_consent,
  solve_consent,
  archive_bank_accounts,
  loading_workspaces,
  loading_service_providers,
  update_bank_account,
  approve_bank_transaction,
  revert_bank_transaction,
  search_bank_transactions,
  export_bank_accounts,
  create_creditor,
  search_payment_submissions,
  create_payment_submission,
  load_payment_submission,
  load_currency_exchange,
  get_invitation,
  consume_invitation,
  register_push_id,
  toggle_push_notifications,
  check_app_updates,
  currency_symbol,
}
