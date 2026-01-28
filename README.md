# Spring Boot App – EKS CI/CD

이 프로젝트는 **GitHub Actions + OIDC + ECR + Amazon EKS**를 사용하여  
Spring Boot 애플리케이션을 자동으로 빌드 및 배포하는 예제입니다.

---

## 🏗 Architecture

- GitHub Actions (OIDC)
- Amazon ECR (Docker Image Registry)
- Amazon EKS
- Kubernetes (Deployment / Service)

---

## 🚀 CI/CD Flow

1. `main` 브랜치에 push
2. GitHub Actions 실행
3. OIDC로 AWS IAM Role Assume
4. Docker 이미지 빌드
5. ECR에 이미지 Push
6. EKS에 Deployment 업데이트 (Rolling Update)

---

## 📂 Repository Structure

```text
.
├─ .github/workflows   # GitHub Actions
├─ k8s/                # Kubernetes manifests
├─ dockerfile          # Docker build file
├─ src/                # Spring Boot source
└─ README.md
