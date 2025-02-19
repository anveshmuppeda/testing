<?xml version="1.0" ?>
<testsuites name="trivy">
{{- range . -}}
{{- $failures := len .Vulnerabilities }}
    <testsuite tests="{{ $failures }}" failures="{{ $failures }}" name="{{ .Target }}" errors="0" skipped="0" time="">
        <properties>
            <property name="image" value="{{ .Target }}" />
            {{- if not (eq .Type "") }}
                <property name="type" value="{{ .Type }}" />
            {{- end }}
        </properties>
        {{ range .Vulnerabilities }}
        <testcase classname="{{ .PkgName }}-{{ .InstalledVersion }}" name="[{{ .Vulnerability.Severity }}] {{ .VulnerabilityID }}" time="">
            <failure message="{{ escapeXML .Title }}" type="description">{{ escapeXML .Description }}</failure>
        </testcase>
        {{- end }}
    </testsuite>

{{- if .MisconfSummary }}
    <testsuite tests="{{ add .MisconfSummary.Successes .MisconfSummary.Failures }}" failures="{{ .MisconfSummary.Failures }}" name="{{ .Target }}" errors="0" time="">
{{- else }}
    <testsuite tests="0" failures="0" name="{{ .Target }}" errors="0" skipped="0" time="">
{{- end }}
        <properties>
            <property name="image" value="{{ .Target }}" />
            {{- if not (eq .Type "") }}
                <property name="type" value="{{ .Type }}" />
            {{- end }}
        </properties>
        {{ range .Misconfigurations }}
        <testcase classname="{{ .Type }}" name="[{{ .Severity }}] {{ .ID }}" time="">
            {{- if eq .Status "FAIL" }}
                <failure message="{{ escapeXML .Title }}" type="description">{{ escapeXML .Description }}</failure>
            {{- end }}
        </testcase>
        {{- end }}
    </testsuite>

{{- if .Licenses }}
    {{- $licenses := len .Licenses }}
    <testsuite tests="{{ $licenses }}" failures="{{ $licenses }}" name="{{ .Target }}" time="0">
        <properties>
            <property name="image" value="{{ .Target }}" />
        </properties>
        {{ range .Licenses }}
        <testcase classname="{{ .PkgName }}" name="[{{ .Severity }}] {{ .Name }}">
            <failure/>
        </testcase>
        {{- end }}
    </testsuite>
{{- end }}

{{- if .Secrets }}
    {{- $secrets := len .Secrets }}
    <testsuite tests="{{ $secrets }}" failures="{{ $secrets }}" name="{{ .Target }}" time="0">
        <properties>
            <property name="image" value="{{ .Target }}" />
        </properties>
        {{ range .Secrets }}
        <testcase classname="{{ .RuleID }}" name="[{{ .Severity }}] {{ .Title }}">
            <failure message="{{ .Title }}" type="description">{{ escapeXML .Match }}</failure>
        </testcase>
        {{- end }}
    </testsuite>
{{- end }}

{{- end }}
</testsuites>
