# Software Engineering Knowledge

Эта папка содержит тематические заметки для будущих agent skills. Главная рамка:
software engineering отличается от программирования тем, что учитывает время,
масштаб, изменение, людей, процессы и стоимость поддержки.

## How To Use

1. Начинайте с [01-engineering-over-time-and-scale.md](01-engineering-over-time-and-scale.md).
2. Для командной работы и культуры читайте [03-team-culture-and-knowledge-sharing.md](03-team-culture-and-knowledge-sharing.md), [04-leadership-ownership-and-delegation.md](04-leadership-ownership-and-delegation.md), [05-equity-and-user-harm.md](05-equity-and-user-harm.md).
3. Для code health используйте [06-style-guides-rules-and-consistency.md](06-style-guides-rules-and-consistency.md), [07-code-review-and-change-history.md](07-code-review-and-change-history.md), [08-documentation-as-code.md](08-documentation-as-code.md).
4. Для качества и изменения систем читайте [09-testing-strategy-and-confidence.md](09-testing-strategy-and-confidence.md), [10-unit-tests-and-maintainability.md](10-unit-tests-and-maintainability.md), [11-test-doubles-fakes-and-mocks.md](11-test-doubles-fakes-and-mocks.md), [12-larger-tests-and-system-behavior.md](12-larger-tests-and-system-behavior.md).
5. Для масштабирования репозитория, сборки и миграций читайте [13-version-control-branching-and-one-version.md](13-version-control-branching-and-one-version.md), [14-builds-and-dependency-management.md](14-builds-and-dependency-management.md), [15-code-search-static-analysis-and-tooling.md](15-code-search-static-analysis-and-tooling.md), [16-deprecation-large-scale-change-and-migration.md](16-deprecation-large-scale-change-and-migration.md).
6. Для production-facing практик используйте [17-ci-cd-release-and-production-safety.md](17-ci-cd-release-and-production-safety.md), [18-managed-compute-and-production-abstractions.md](18-managed-compute-and-production-abstractions.md).
7. Для превращения этой базы в skill используйте [19-swe-agent-operating-model.md](19-swe-agent-operating-model.md).

## Files

- [01-engineering-over-time-and-scale.md](01-engineering-over-time-and-scale.md): время, масштаб, Hyrum's Law, устойчивость к изменениям.
- [02-decision-making-and-productivity-measurement.md](02-decision-making-and-productivity-measurement.md): trade-offs, обратимость, GSM/QUANTS, actionable metrics.
- [03-team-culture-and-knowledge-sharing.md](03-team-culture-and-knowledge-sharing.md): HRT, психологическая безопасность, bus factor, обучение и канонические знания.
- [04-leadership-ownership-and-delegation.md](04-leadership-ownership-and-delegation.md): leadership vs management, делегирование, self-driving teams.
- [05-equity-and-user-harm.md](05-equity-and-user-harm.md): bias, diversity, инклюзивность и продуктовый вред.
- [06-style-guides-rules-and-consistency.md](06-style-guides-rules-and-consistency.md): правила, consistency, guidance, форматтеры и автоматизация.
- [07-code-review-and-change-history.md](07-code-review-and-change-history.md): ревью как качество, обучение, ownership и исторический след.
- [08-documentation-as-code.md](08-documentation-as-code.md): документация как часть engineering workflow.
- [09-testing-strategy-and-confidence.md](09-testing-strategy-and-confidence.md): тестовая стратегия, test size/scope, flakiness, coverage limits.
- [10-unit-tests-and-maintainability.md](10-unit-tests-and-maintainability.md): behavior tests, public API, DAMP, ясность.
- [11-test-doubles-fakes-and-mocks.md](11-test-doubles-fakes-and-mocks.md): real implementations, fakes, stubs, interaction testing.
- [12-larger-tests-and-system-behavior.md](12-larger-tests-and-system-behavior.md): integration/system tests, fidelity, load, probers, canary analysis.
- [13-version-control-branching-and-one-version.md](13-version-control-branching-and-one-version.md): source of truth, trunk, one-version rule, branch risk.
- [14-builds-and-dependency-management.md](14-builds-and-dependency-management.md): artifact builds, hermeticity, dependency contracts, SemVer limits.
- [15-code-search-static-analysis-and-tooling.md](15-code-search-static-analysis-and-tooling.md): code search, review tooling, static analysis, suggested fixes.
- [16-deprecation-large-scale-change-and-migration.md](16-deprecation-large-scale-change-and-migration.md): deprecation, migration, LSC process.
- [17-ci-cd-release-and-production-safety.md](17-ci-cd-release-and-production-safety.md): CI, CD, flags, release trains, staged rollout.
- [18-managed-compute-and-production-abstractions.md](18-managed-compute-and-production-abstractions.md): CaaS, failure-oriented software, state, abstractions.
- [19-swe-agent-operating-model.md](19-swe-agent-operating-model.md): how an agent should apply the knowledge.

## Notes

Treat organization-specific practices as examples of principles under time,
scale, and cost constraints, not as universal rules.
