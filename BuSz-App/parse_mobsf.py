import json

with open('mobsf_report.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

with open('mobsf_summary.md', 'w', encoding='utf-8') as out:
    out.write('# MobSF Security Report - BusZ APK\n\n')
    out.write(f'**App Name:** {data.get("app_name")}\n')
    out.write(f'**Security Score:** {data.get("security_score")}/100\n')
    out.write(f'**Trackers:** {data.get("trackers")}\n\n')

    out.write('## Manifest Analysis (High/Warning)\n')
    if 'manifest_analysis' in data and 'manifest_findings' in data['manifest_analysis']:
        for finding in data['manifest_analysis']['manifest_findings']:
            severity = finding.get("severity", "").upper()
            if severity in ['HIGH', 'WARNING']:
                out.write(f'- **[{severity}]** {finding.get("title")}: {finding.get("description")}\n')

    out.write('\n## Network Security\n')
    if 'network_security' in data and isinstance(data['network_security'], dict):
        for severity, findings in data['network_security'].items():
            if isinstance(findings, list):
                for finding in findings:
                    if isinstance(finding, dict):
                        out.write(f'- **[{severity.upper()}]** {finding.get("title")}\n')

    out.write('\n## Code Analysis\n')
    if 'code_analysis' in data and 'findings' in data['code_analysis']:
        for k, v in data['code_analysis']['findings'].items():
            severity = v.get("metadata", {}).get("severity", "").upper()
            if severity in ['HIGH', 'WARNING']:
                out.write(f'- **[{severity}]** {v.get("metadata", {}).get("description")}\n')
