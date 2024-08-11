from django.contrib import admin
from .models import LiveChatSession, ChatHistory, AgentAvailability, SupportTicket, FAQ, KnowledgeBaseArticle, CustomerFeedback, Escalation, SupportAnalytics, SupportAvailability, SupportLanguage, SupportResource, AgentPerformance, SupportIntegration

class LiveChatSessionAdmin(admin.ModelAdmin):
    list_display = ('session_id', 'customer_id', 'agent_id', 'start_time', 'end_time', 'status', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'agent_id', 'status')

class ChatHistoryAdmin(admin.ModelAdmin):
    list_display = ('message_id', 'session_id', 'sender_id', 'message_content', 'sent_at', 'created_at', 'updated_at')
    search_fields = ('session_id', 'sender_id')

class AgentAvailabilityAdmin(admin.ModelAdmin):
    list_display = ('agent_id', 'available', 'available_from', 'available_to', 'created_at', 'updated_at')
    search_fields = ('agent_id',)

class SupportTicketAdmin(admin.ModelAdmin):
    list_display = ('ticket_id', 'customer_id', 'subject', 'status', 'priority', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'subject', 'status', 'priority')

class FAQAdmin(admin.ModelAdmin):
    list_display = ('faq_id', 'question', 'answer', 'created_at', 'updated_at')
    search_fields = ('question',)

class KnowledgeBaseArticleAdmin(admin.ModelAdmin):
    list_display = ('article_id', 'title', 'content', 'created_at', 'updated_at')
    search_fields = ('title',)

class CustomerFeedbackAdmin(admin.ModelAdmin):
    list_display = ('feedback_id', 'customer_id', 'ticket_id', 'feedback_text', 'response', 'submitted_at', 'responded_at', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'ticket_id', 'feedback_text')

class EscalationAdmin(admin.ModelAdmin):
    list_display = ('escalation_id', 'ticket_id', 'escalated_to', 'reason', 'created_at', 'updated_at')
    search_fields = ('ticket_id', 'escalated_to')

class SupportAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'type', 'data', 'created_at', 'updated_at')
    search_fields = ('type',)

class SupportAvailabilityAdmin(admin.ModelAdmin):
    list_display = ('date', 'availability', 'created_at', 'updated_at')
    search_fields = ('date',)

class SupportLanguageAdmin(admin.ModelAdmin):
    list_display = ('language_id', 'language_code', 'language_name', 'created_at', 'updated_at')
    search_fields = ('language_code', 'language_name')

class SupportResourceAdmin(admin.ModelAdmin):
    list_display = ('resource_id', 'type', 'title', 'content', 'created_at', 'updated_at')
    search_fields = ('type', 'title')

class AgentPerformanceAdmin(admin.ModelAdmin):
    list_display = ('agent_id', 'performance_data', 'created_at', 'updated_at')
    search_fields = ('agent_id',)

class SupportIntegrationAdmin(admin.ModelAdmin):
    list_display = ('integration_id', 'type', 'details', 'created_at', 'updated_at')
    search_fields = ('type',)

admin.site.register(LiveChatSession, LiveChatSessionAdmin)
admin.site.register(ChatHistory, ChatHistoryAdmin)
admin.site.register(AgentAvailability, AgentAvailabilityAdmin)
admin.site.register(SupportTicket, SupportTicketAdmin)
admin.site.register(FAQ, FAQAdmin)
admin.site.register(KnowledgeBaseArticle, KnowledgeBaseArticleAdmin)
admin.site.register(CustomerFeedback, CustomerFeedbackAdmin)
admin.site.register(Escalation, EscalationAdmin)
admin.site.register(SupportAnalytics, SupportAnalyticsAdmin)
admin.site.register(SupportAvailability, SupportAvailabilityAdmin)
admin.site.register(SupportLanguage, SupportLanguageAdmin)
admin.site.register(SupportResource, SupportResourceAdmin)
admin.site.register(AgentPerformance, AgentPerformanceAdmin)
admin.site.register(SupportIntegration, SupportIntegrationAdmin)
