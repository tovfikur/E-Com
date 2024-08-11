from django.db import models

class LiveChatSession(models.Model):
    session_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    agent_id = models.IntegerField()
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ChatHistory(models.Model):
    message_id = models.AutoField(primary_key=True)
    session_id = models.ForeignKey(LiveChatSession, on_delete=models.CASCADE)
    sender_id = models.IntegerField()
    message_content = models.TextField()
    sent_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class AgentAvailability(models.Model):
    agent_id = models.IntegerField(primary_key=True)
    available = models.BooleanField()
    available_from = models.DateTimeField()
    available_to = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SupportTicket(models.Model):
    ticket_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    subject = models.CharField(max_length=255)
    description = models.TextField()
    status = models.CharField(max_length=50)
    priority = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class FAQ(models.Model):
    faq_id = models.AutoField(primary_key=True)
    question = models.CharField(max_length=255)
    answer = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class KnowledgeBaseArticle(models.Model):
    article_id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=255)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CustomerFeedback(models.Model):
    feedback_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    ticket_id = models.IntegerField()
    feedback_text = models.TextField()
    response = models.TextField()
    submitted_at = models.DateTimeField()
    responded_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class Escalation(models.Model):
    escalation_id = models.AutoField(primary_key=True)
    ticket_id = models.IntegerField()
    escalated_to = models.CharField(max_length=255)
    reason = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SupportAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    type = models.CharField(max_length=50)
    data = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SupportAvailability(models.Model):
    date = models.DateField(primary_key=True)
    availability = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SupportLanguage(models.Model):
    language_id = models.AutoField(primary_key=True)
    language_code = models.CharField(max_length=10)
    language_name = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SupportResource(models.Model):
    resource_id = models.AutoField(primary_key=True)
    type = models.CharField(max_length=50)
    title = models.CharField(max_length=255)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class AgentPerformance(models.Model):
    agent_id = models.IntegerField(primary_key=True)
    performance_data = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SupportIntegration(models.Model):
    integration_id = models.AutoField(primary_key=True)
    type = models.CharField(max_length=50)
    details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
