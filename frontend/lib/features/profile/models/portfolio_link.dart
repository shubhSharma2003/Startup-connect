import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_link.freezed.dart';
part 'portfolio_link.g.dart';

@freezed
class PortfolioLink with _$PortfolioLink {
  const factory PortfolioLink({
    required int id,
    required String title,
    required String url,
  }) = _PortfolioLink;

  factory PortfolioLink.fromJson(Map<String, dynamic> json) => _$PortfolioLinkFromJson(json);
}
